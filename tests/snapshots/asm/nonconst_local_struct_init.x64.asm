
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x2a, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x63, %r10d
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x18(%rbp), %r8
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	0x20(%rsp), %rsi
               	movslq	%esi, %rsi
               	leaq	-0x18(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	0x28(%rsp), %r8
               	movslq	%r8d, %r8
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	%r8d, (%rdi)
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	cmpq	$0x2a, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rdi
               	cmpq	$0x63, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r15
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movl	$0x7, %r15d
               	leaq	-0x20(%rbp), %rax
               	movl	%r15d, (%rax)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x20(%rbp), %r15
               	movslq	(%r15), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r12
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movl	$0xb, %r15d
               	leaq	-0x28(%rbp), %rax
               	movl	%r15d, (%rax)
               	movl	$0x16, %r12d
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r12
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r12)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r12)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r12)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movq	0x20(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x38(%rbp), %rax
               	movl	%r15d, (%rax)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x38(%rbp), %r15
               	movslq	(%r15), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	addq	$0x8, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rbx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rbx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rbx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rbx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rbx)
               	popq	%r11
               	movq	%rbx, %r12
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	movq	0x20(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x48(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x48(%rbp), %r12
               	movslq	(%r12), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %r12
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r15
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r15)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r15)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r15)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r15)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r15)
               	popq	%r11
               	movq	%r15, %rbx
               	movq	0x20(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x58(%rbp), %rax
               	movl	%ebx, (%rax)
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r15d, (%rax)
               	leaq	-0x58(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rbx
               	addq	$0x8, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rbx
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r15
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %r12
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r12)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r12)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r12)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r12)
               	popq	%r11
               	movq	%r12, %r15
               	leaq	-0x78(%rbp), %r15
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r15)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r15)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r15)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r15)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r15)
               	popq	%r11
               	movq	%r15, %r12
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x78(%rbp), %r15
               	movslq	(%r15), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	jmp	<addr>
               	movq	-0xf0(%rbp), %rax
               	movq	%rax, -0xe8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %r15
               	addq	$0x8, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
