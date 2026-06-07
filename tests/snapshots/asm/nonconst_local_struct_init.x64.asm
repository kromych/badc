
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movq	(%rcx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x2a, %ebx
               	movl	$0x63, %r12d
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movl	$0x7, %eax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movl	$0xb, %edi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x16, %edi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x38(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x58(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
