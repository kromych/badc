
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
               	movq	%rdi, %rax
               	shlq	$0x8, %rax
               	movslq	%eax, %rcx
               	movswq	%cx, %rax
               	retq

<s8_wrap>:
               	movq	%rdi, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rcx
               	movsbq	%cl, %rax
               	retq

<main>:
               	movl	$0x3412, %eax           # imm = 0x3412
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	shlq	$0x8, %rax
               	movslq	%eax, %rax
               	orq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x64, %eax
               	andq	$0xff, %rax
               	addq	$0xc8, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	xorq	$0x2c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x140, %eax            # imm = 0x140
               	movswq	%ax, %rax
               	shlq	$0x8, %rax
               	movslq	%eax, %rcx
               	movswq	%cx, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x64, %eax
               	movsbq	%al, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rcx
               	movsbq	%cl, %rax
               	cmpq	$-0x38, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
