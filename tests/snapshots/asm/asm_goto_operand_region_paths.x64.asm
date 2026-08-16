
asm_goto_operand_region_paths.x64:	file format elf64-x86-64

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

<patched>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movslq	%edi, %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	jmpq	*%rbx
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<vla_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x9, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movl	$0x9, %ecx
               	movb	%cl, (%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x8(%rax)
               	movsbq	%cl, %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rax), %rcx
               	movsbq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x2, %eax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movl	$0x7, %eax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edx
               	leaq	-0x50(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, (%rax)
               	movl	$0x2, %ecx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x64, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rdx, %rdx
               	leaq	-0x50(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, (%rax)
               	movl	$0x2, %ecx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x64, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movl	%ebx, %eax
               	movq	-0x30(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movslq	-0x18(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movl	%ebx, %eax
               	movq	-0x30(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movslq	-0x18(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
