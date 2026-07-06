
sub_word_return_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bswap16>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	shlq	$0x8, %rax
               	movslq	%eax, %rax
               	orq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<u8_wrap>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	addq	$0xc8, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	retq

<s16_shift>:
               	movswq	%di, %rdi
               	movq	%rdi, %rax
               	shlq	$0x8, %rax
               	movslq	%eax, %rcx
               	movswq	%cx, %rax
               	retq

<s8_wrap>:
               	movsbq	%dil, %rdi
               	leaq	0x64(%rdi), %rax
               	movslq	%eax, %rcx
               	movsbq	%cl, %rax
               	retq

<main>:
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
