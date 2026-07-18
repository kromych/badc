
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0xdeadbeef, %eax       # imm = 0xDEADBEEF
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x18, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
