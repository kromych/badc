
struct_multi_byval.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_many>:
               	popq	%r10
               	subq	$0x80, %rsp
               	movq	0x90(%rsp), %rax
               	movq	%rax, 0x50(%rsp)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%r13, (%rsp)
               	movq	%rdi, -0x8(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0xa8(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xb0(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0xb8(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movslq	%esi, %rsi
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x60(%rbp), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x10(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x14(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x80(%rbp), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x80, %rsp
               	pushq	%r11
               	retq

<make2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rdi, %rcx
               	incq	%rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<make4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %rcx
               	incq	%rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<make6>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x5, %rcx
               	movl	%ecx, 0x14(%rax)
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x30(%rbp), %r8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	leaq	-0x48(%rbp), %rax
               	movl	$0xbb8, %r11d           # imm = 0xBB8
               	subq	$0x40, %rsp
               	movq	%r9, 0x10(%rsp)
               	movq	%r11, 0x30(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r13
               	movq	%r13, (%rsp)
               	movq	0x8(%r10), %r13
               	movq	%r13, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r13
               	movq	%r13, 0x18(%rsp)
               	movq	0x8(%r10), %r13
               	movq	%r13, 0x20(%rsp)
               	movq	0x10(%r10), %r13
               	movq	%r13, 0x28(%rsp)
               	movq	%rcx, %r8
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1a12, %rax           # imm = 0x1A12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movl	$0x32, %edi
               	callq	<addr>
               	movq	%rax, -0xc8(%rbp)
               	leaq	-0xc8(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x33, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movl	$0x3c, %edi
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x3d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x3f, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	-0x110(%rbp), %rdi
               	movl	$0x46, %esi
               	callq	<addr>
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x90(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x46, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x47, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x48, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %ebx
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x49, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x4a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x4b, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x50(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movq	%rax, -0x148(%rbp)
               	leaq	-0x148(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x65, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x66, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addb	%al, 0x41(%rdx)
