
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<triple_plus_one>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<bit_count>:
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	addq	%rax, %rcx
               	shrq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
