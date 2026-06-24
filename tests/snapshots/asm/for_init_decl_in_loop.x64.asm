
for_init_decl_in_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<run>:
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movslq	%edx, %rax
               	retq
               	movslq	%esi, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	incq	%rsi
               	jmp	<addr>
               	imulq	$0x64, %rcx, %rax
               	addq	%rsi, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x4060, %rax           # imm = 0x4060
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
