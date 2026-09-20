
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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	$0x1, -0x10(%rbp)
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x10(%rbp)
               	movb	%bl, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x18(%rbp)
               	cmpq	$0x3, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x18(%rbp)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, %rax
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x10(%rbp)
               	movb	%bl, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	addq	$0xc, %rcx
               	movq	%rcx, -0x18(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
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
               	movb	%al, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %ebx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movb	%al, -0x10(%rbp)
               	cmpb	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movb	%al, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %ebx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movb	%al, -0x10(%rbp)
               	cmpb	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x8(%rbp)
               	movb	%bl, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$0x1, -0x8(%rbp)
               	movl	$0x1, %eax
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, -0x8(%rbp)
               	movb	%bl, -0x10(%rbp)
               	cmpb	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, -0x10(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x4, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0xffffffff, -0x10(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x7, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
