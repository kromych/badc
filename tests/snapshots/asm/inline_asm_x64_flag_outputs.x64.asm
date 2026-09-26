
inline_asm_x64_flag_outputs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x10(%rbp)
               	movq	%rbx, -0x8(%rbp)
               	cmpq	$0x3, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rax
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x10(%rbp)
               	leaq	0xc(%rbx), %rcx
               	movq	%rcx, -0x8(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %ebx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %ebx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x7, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
