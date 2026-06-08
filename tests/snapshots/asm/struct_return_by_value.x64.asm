
struct_return_by_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rdi, %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, -0x90(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	callq	<addr>
               	movq	%rax, -0xc0(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movl	$0x1e, %esi
               	callq	<addr>
               	leaq	-0xc8(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rbx
               	movl	$0x28, %edi
               	callq	<addr>
               	movq	%rax, -0xd8(%rbp)
               	leaq	-0xd8(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x28, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x29, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
