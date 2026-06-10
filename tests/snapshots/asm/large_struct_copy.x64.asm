
large_struct_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x2f0, %esi            # imm = 0x2F0
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
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
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x480, %rsp            # imm = 0x480
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0xc8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x190, %ecx            # imm = 0x190
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x210(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movl	%ecx, 0xb0(%rax)
               	leaq	-0x210(%rbp), %rax
               	movabsq	$-0x2, %rcx
               	movl	%ecx, 0x154(%rax)
               	leaq	-0x210(%rbp), %rax
               	movabsq	$-0x3, %rcx
               	movl	%ecx, 0x1f8(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x1f4, %ecx            # imm = 0x1F4
               	movl	%ecx, 0x1fc(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x258, %ecx            # imm = 0x258
               	movl	%ecx, 0x200(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x2bc, %ecx            # imm = 0x2BC
               	movl	%ecx, 0x204(%rax)
               	leaq	-0x210(%rbp), %rax
               	movl	$0x320, %ecx            # imm = 0x320
               	movl	%ecx, 0x208(%rax)
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x28, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x210(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movl	%esi, (%rax,%rdx,4)
               	leaq	-0x210(%rbp), %rax
               	addq	$0xb4, %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0x7d0, %rsi            # imm = 0x7D0
               	movl	%esi, (%rax,%rdx,4)
               	leaq	-0x210(%rbp), %rax
               	addq	$0x158, %rax            # imm = 0x158
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0xbb8, %rsi            # imm = 0xBB8
               	movl	%esi, (%rax,%rdx,4)
               	jmp	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x420(%rbp), %rax
               	leaq	-0x210(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rcx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rcx), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%rcx), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%rcx), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%rcx), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%rcx), %r11
               	movq	%r11, 0x58(%rax)
               	movq	0x60(%rcx), %r11
               	movq	%r11, 0x60(%rax)
               	movq	0x68(%rcx), %r11
               	movq	%r11, 0x68(%rax)
               	movq	0x70(%rcx), %r11
               	movq	%r11, 0x70(%rax)
               	movq	0x78(%rcx), %r11
               	movq	%r11, 0x78(%rax)
               	movq	0x80(%rcx), %r11
               	movq	%r11, 0x80(%rax)
               	movq	0x88(%rcx), %r11
               	movq	%r11, 0x88(%rax)
               	movq	0x90(%rcx), %r11
               	movq	%r11, 0x90(%rax)
               	movq	0x98(%rcx), %r11
               	movq	%r11, 0x98(%rax)
               	movq	0xa0(%rcx), %r11
               	movq	%r11, 0xa0(%rax)
               	movq	0xa8(%rcx), %r11
               	movq	%r11, 0xa8(%rax)
               	movq	0xb0(%rcx), %r11
               	movq	%r11, 0xb0(%rax)
               	movq	0xb8(%rcx), %r11
               	movq	%r11, 0xb8(%rax)
               	movq	0xc0(%rcx), %r11
               	movq	%r11, 0xc0(%rax)
               	movq	0xc8(%rcx), %r11
               	movq	%r11, 0xc8(%rax)
               	movq	0xd0(%rcx), %r11
               	movq	%r11, 0xd0(%rax)
               	movq	0xd8(%rcx), %r11
               	movq	%r11, 0xd8(%rax)
               	movq	0xe0(%rcx), %r11
               	movq	%r11, 0xe0(%rax)
               	movq	0xe8(%rcx), %r11
               	movq	%r11, 0xe8(%rax)
               	movq	0xf0(%rcx), %r11
               	movq	%r11, 0xf0(%rax)
               	movq	0xf8(%rcx), %r11
               	movq	%r11, 0xf8(%rax)
               	movq	0x100(%rcx), %r11
               	movq	%r11, 0x100(%rax)
               	movq	0x108(%rcx), %r11
               	movq	%r11, 0x108(%rax)
               	movq	0x110(%rcx), %r11
               	movq	%r11, 0x110(%rax)
               	movq	0x118(%rcx), %r11
               	movq	%r11, 0x118(%rax)
               	movq	0x120(%rcx), %r11
               	movq	%r11, 0x120(%rax)
               	movq	0x128(%rcx), %r11
               	movq	%r11, 0x128(%rax)
               	movq	0x130(%rcx), %r11
               	movq	%r11, 0x130(%rax)
               	movq	0x138(%rcx), %r11
               	movq	%r11, 0x138(%rax)
               	movq	0x140(%rcx), %r11
               	movq	%r11, 0x140(%rax)
               	movq	0x148(%rcx), %r11
               	movq	%r11, 0x148(%rax)
               	movq	0x150(%rcx), %r11
               	movq	%r11, 0x150(%rax)
               	movq	0x158(%rcx), %r11
               	movq	%r11, 0x158(%rax)
               	movq	0x160(%rcx), %r11
               	movq	%r11, 0x160(%rax)
               	movq	0x168(%rcx), %r11
               	movq	%r11, 0x168(%rax)
               	movq	0x170(%rcx), %r11
               	movq	%r11, 0x170(%rax)
               	movq	0x178(%rcx), %r11
               	movq	%r11, 0x178(%rax)
               	movq	0x180(%rcx), %r11
               	movq	%r11, 0x180(%rax)
               	movq	0x188(%rcx), %r11
               	movq	%r11, 0x188(%rax)
               	movq	0x190(%rcx), %r11
               	movq	%r11, 0x190(%rax)
               	movq	0x198(%rcx), %r11
               	movq	%r11, 0x198(%rax)
               	movq	0x1a0(%rcx), %r11
               	movq	%r11, 0x1a0(%rax)
               	movq	0x1a8(%rcx), %r11
               	movq	%r11, 0x1a8(%rax)
               	movq	0x1b0(%rcx), %r11
               	movq	%r11, 0x1b0(%rax)
               	movq	0x1b8(%rcx), %r11
               	movq	%r11, 0x1b8(%rax)
               	movq	0x1c0(%rcx), %r11
               	movq	%r11, 0x1c0(%rax)
               	movq	0x1c8(%rcx), %r11
               	movq	%r11, 0x1c8(%rax)
               	movq	0x1d0(%rcx), %r11
               	movq	%r11, 0x1d0(%rax)
               	movq	0x1d8(%rcx), %r11
               	movq	%r11, 0x1d8(%rax)
               	movq	0x1e0(%rcx), %r11
               	movq	%r11, 0x1e0(%rax)
               	movq	0x1e8(%rcx), %r11
               	movq	%r11, 0x1e8(%rax)
               	movq	0x1f0(%rcx), %r11
               	movq	%r11, 0x1f0(%rax)
               	movq	0x1f8(%rcx), %r11
               	movq	%r11, 0x1f8(%rax)
               	movq	0x200(%rcx), %r11
               	movq	%r11, 0x200(%rax)
               	movzbq	0x208(%rcx), %r11
               	movb	%r11b, 0x208(%rax)
               	movzbq	0x209(%rcx), %r11
               	movb	%r11b, 0x209(%rax)
               	movzbq	0x20a(%rcx), %r11
               	movb	%r11b, 0x20a(%rax)
               	movzbq	0x20b(%rcx), %r11
               	movb	%r11b, 0x20b(%rax)
               	popq	%r11
               	leaq	-0x420(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xc8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x190, %rax            # imm = 0x190
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movslq	0x1fc(%rax), %rax
               	cmpq	$0x1f4, %rax            # imm = 0x1F4
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0x200(%rax), %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0x204(%rax), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	movslq	0x208(%rax), %rax
               	cmpq	$0x320, %rax            # imm = 0x320
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movslq	0xb0(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movslq	0x154(%rax), %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	movslq	0x1f8(%rax), %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x28, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	leaq	-0x420(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	%ebx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0xb4, %rax
               	movslq	%ebx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	$0x7d0, %rcx            # imm = 0x7D0
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movslq	%ebx, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0x158, %rax            # imm = 0x158
               	movslq	%ebx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	$0xbb8, %rcx            # imm = 0xBB8
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movslq	%ebx, %rax
               	addq	$0x6e, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
