
large_struct_copy.x64:	file format elf64-x86-64

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
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
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
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x490, %rsp            # imm = 0x490
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x210(%rbp), %r11
               	movl	$0x64, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x210(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0xc8, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x210(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0x12c, %r9d            # imm = 0x12C
               	movl	%r9d, (%r11)
               	leaq	-0x210(%rbp), %r8
               	addq	$0xc, %r8
               	movl	$0x190, %r9d            # imm = 0x190
               	movl	%r9d, (%r8)
               	leaq	-0x210(%rbp), %r11
               	addq	$0xb0, %r11
               	movabsq	$-0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x210(%rbp), %r8
               	addq	$0x154, %r8             # imm = 0x154
               	movabsq	$-0x2, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x210(%rbp), %r11
               	addq	$0x1f8, %r11            # imm = 0x1F8
               	movabsq	$-0x3, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x210(%rbp), %r8
               	addq	$0x1fc, %r8             # imm = 0x1FC
               	movl	$0x1f4, %r9d            # imm = 0x1F4
               	movl	%r9d, (%r8)
               	leaq	-0x210(%rbp), %r11
               	addq	$0x200, %r11            # imm = 0x200
               	movl	$0x258, %r9d            # imm = 0x258
               	movl	%r9d, (%r11)
               	leaq	-0x210(%rbp), %r8
               	addq	$0x204, %r8             # imm = 0x204
               	movl	$0x2bc, %r9d            # imm = 0x2BC
               	movl	%r9d, (%r8)
               	leaq	-0x210(%rbp), %r11
               	addq	$0x208, %r11            # imm = 0x208
               	movl	$0x320, %r9d            # imm = 0x320
               	movl	%r9d, (%r11)
               	xorq	%r8, %r8
               	movl	%r8d, -0x428(%rbp)
               	jmp	<addr>
               	movslq	-0x428(%rbp), %r8
               	cmpq	$0x28, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x428(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x210(%rbp), %r8
               	addq	$0x10, %r8
               	movslq	-0x428(%rbp), %r11
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r8
               	addq	$0x3e8, %r11            # imm = 0x3E8
               	movslq	%r11d, %r11
               	movl	%r11d, (%r8)
               	leaq	-0x210(%rbp), %r9
               	addq	$0xb4, %r9
               	movslq	-0x428(%rbp), %r11
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	$0x7d0, %r11            # imm = 0x7D0
               	movslq	%r11d, %r11
               	movl	%r11d, (%r9)
               	leaq	-0x210(%rbp), %r8
               	addq	$0x158, %r8             # imm = 0x158
               	movslq	-0x428(%rbp), %r11
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r8
               	addq	$0xbb8, %r11            # imm = 0xBB8
               	movslq	%r11d, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	-0x420(%rbp), %rbx
               	movl	$0x7e, %r12d
               	movl	$0x20c, %r14d           # imm = 0x20C
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x420(%rbp), %rax
               	leaq	-0x210(%rbp), %r14
               	pushq	%r11
               	movq	(%r14), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r14), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%r14), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%r14), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%r14), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%r14), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%r14), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%r14), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%r14), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%r14), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%r14), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%r14), %r11
               	movq	%r11, 0x58(%rax)
               	movq	0x60(%r14), %r11
               	movq	%r11, 0x60(%rax)
               	movq	0x68(%r14), %r11
               	movq	%r11, 0x68(%rax)
               	movq	0x70(%r14), %r11
               	movq	%r11, 0x70(%rax)
               	movq	0x78(%r14), %r11
               	movq	%r11, 0x78(%rax)
               	movq	0x80(%r14), %r11
               	movq	%r11, 0x80(%rax)
               	movq	0x88(%r14), %r11
               	movq	%r11, 0x88(%rax)
               	movq	0x90(%r14), %r11
               	movq	%r11, 0x90(%rax)
               	movq	0x98(%r14), %r11
               	movq	%r11, 0x98(%rax)
               	movq	0xa0(%r14), %r11
               	movq	%r11, 0xa0(%rax)
               	movq	0xa8(%r14), %r11
               	movq	%r11, 0xa8(%rax)
               	movq	0xb0(%r14), %r11
               	movq	%r11, 0xb0(%rax)
               	movq	0xb8(%r14), %r11
               	movq	%r11, 0xb8(%rax)
               	movq	0xc0(%r14), %r11
               	movq	%r11, 0xc0(%rax)
               	movq	0xc8(%r14), %r11
               	movq	%r11, 0xc8(%rax)
               	movq	0xd0(%r14), %r11
               	movq	%r11, 0xd0(%rax)
               	movq	0xd8(%r14), %r11
               	movq	%r11, 0xd8(%rax)
               	movq	0xe0(%r14), %r11
               	movq	%r11, 0xe0(%rax)
               	movq	0xe8(%r14), %r11
               	movq	%r11, 0xe8(%rax)
               	movq	0xf0(%r14), %r11
               	movq	%r11, 0xf0(%rax)
               	movq	0xf8(%r14), %r11
               	movq	%r11, 0xf8(%rax)
               	movq	0x100(%r14), %r11
               	movq	%r11, 0x100(%rax)
               	movq	0x108(%r14), %r11
               	movq	%r11, 0x108(%rax)
               	movq	0x110(%r14), %r11
               	movq	%r11, 0x110(%rax)
               	movq	0x118(%r14), %r11
               	movq	%r11, 0x118(%rax)
               	movq	0x120(%r14), %r11
               	movq	%r11, 0x120(%rax)
               	movq	0x128(%r14), %r11
               	movq	%r11, 0x128(%rax)
               	movq	0x130(%r14), %r11
               	movq	%r11, 0x130(%rax)
               	movq	0x138(%r14), %r11
               	movq	%r11, 0x138(%rax)
               	movq	0x140(%r14), %r11
               	movq	%r11, 0x140(%rax)
               	movq	0x148(%r14), %r11
               	movq	%r11, 0x148(%rax)
               	movq	0x150(%r14), %r11
               	movq	%r11, 0x150(%rax)
               	movq	0x158(%r14), %r11
               	movq	%r11, 0x158(%rax)
               	movq	0x160(%r14), %r11
               	movq	%r11, 0x160(%rax)
               	movq	0x168(%r14), %r11
               	movq	%r11, 0x168(%rax)
               	movq	0x170(%r14), %r11
               	movq	%r11, 0x170(%rax)
               	movq	0x178(%r14), %r11
               	movq	%r11, 0x178(%rax)
               	movq	0x180(%r14), %r11
               	movq	%r11, 0x180(%rax)
               	movq	0x188(%r14), %r11
               	movq	%r11, 0x188(%rax)
               	movq	0x190(%r14), %r11
               	movq	%r11, 0x190(%rax)
               	movq	0x198(%r14), %r11
               	movq	%r11, 0x198(%rax)
               	movq	0x1a0(%r14), %r11
               	movq	%r11, 0x1a0(%rax)
               	movq	0x1a8(%r14), %r11
               	movq	%r11, 0x1a8(%rax)
               	movq	0x1b0(%r14), %r11
               	movq	%r11, 0x1b0(%rax)
               	movq	0x1b8(%r14), %r11
               	movq	%r11, 0x1b8(%rax)
               	movq	0x1c0(%r14), %r11
               	movq	%r11, 0x1c0(%rax)
               	movq	0x1c8(%r14), %r11
               	movq	%r11, 0x1c8(%rax)
               	movq	0x1d0(%r14), %r11
               	movq	%r11, 0x1d0(%rax)
               	movq	0x1d8(%r14), %r11
               	movq	%r11, 0x1d8(%rax)
               	movq	0x1e0(%r14), %r11
               	movq	%r11, 0x1e0(%rax)
               	movq	0x1e8(%r14), %r11
               	movq	%r11, 0x1e8(%rax)
               	movq	0x1f0(%r14), %r11
               	movq	%r11, 0x1f0(%rax)
               	movq	0x1f8(%r14), %r11
               	movq	%r11, 0x1f8(%rax)
               	movq	0x200(%r14), %r11
               	movq	%r11, 0x200(%rax)
               	movzbq	0x208(%r14), %r11
               	movb	%r11b, 0x208(%rax)
               	movzbq	0x209(%r14), %r11
               	movb	%r11b, 0x209(%rax)
               	movzbq	0x20a(%r14), %r11
               	movb	%r11b, 0x20a(%rax)
               	movzbq	0x20b(%r14), %r11
               	movb	%r11b, 0x20b(%rax)
               	popq	%r11
               	movq	%rax, %r12
               	leaq	-0x420(%rbp), %r12
               	movslq	(%r12), %r12
               	cmpq	$0x64, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x458(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0x420(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r14
               	cmpq	$0xc8, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x458(%rbp)
               	jmp	<addr>
               	movq	-0x458(%rbp), %r14
               	movq	%r14, -0x450(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x420(%rbp), %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %r12
               	cmpq	$0x12c, %r12            # imm = 0x12C
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x450(%rbp)
               	jmp	<addr>
               	movq	-0x450(%rbp), %r12
               	movq	%r12, -0x448(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0x420(%rbp), %r14
               	addq	$0xc, %r14
               	movslq	(%r14), %r14
               	cmpq	$0x190, %r14            # imm = 0x190
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x448(%rbp)
               	jmp	<addr>
               	movq	-0x448(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r14
               	addq	$0x1fc, %r14            # imm = 0x1FC
               	movslq	(%r14), %r14
               	cmpq	$0x1f4, %r14            # imm = 0x1F4
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x470(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x420(%rbp), %r12
               	addq	$0x200, %r12            # imm = 0x200
               	movslq	(%r12), %r12
               	cmpq	$0x258, %r12            # imm = 0x258
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x470(%rbp)
               	jmp	<addr>
               	movq	-0x470(%rbp), %r12
               	movq	%r12, -0x468(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0x420(%rbp), %r14
               	addq	$0x204, %r14            # imm = 0x204
               	movslq	(%r14), %r14
               	cmpq	$0x2bc, %r14            # imm = 0x2BC
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x468(%rbp)
               	jmp	<addr>
               	movq	-0x468(%rbp), %r14
               	movq	%r14, -0x460(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x420(%rbp), %r12
               	addq	$0x208, %r12            # imm = 0x208
               	movslq	(%r12), %r12
               	cmpq	$0x320, %r12            # imm = 0x320
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x460(%rbp)
               	jmp	<addr>
               	movq	-0x460(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r12
               	addq	$0xb0, %r12
               	movslq	(%r12), %r12
               	cmpq	$-0x1, %r12
               	je	<addr>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r12
               	addq	$0x154, %r12            # imm = 0x154
               	movslq	(%r12), %r12
               	cmpq	$-0x2, %r12
               	je	<addr>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r12
               	addq	$0x1f8, %r12            # imm = 0x1F8
               	movslq	(%r12), %r12
               	cmpq	$-0x3, %r12
               	je	<addr>
               	movl	$0x5, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x428(%rbp)
               	jmp	<addr>
               	movslq	-0x428(%rbp), %r12
               	cmpq	$0x28, %r12
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x428(%rbp), %r14
               	movslq	(%r14), %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r14)
               	jmp	<addr>
               	leaq	-0x420(%rbp), %r12
               	addq	$0x10, %r12
               	movslq	-0x428(%rbp), %rax
               	movq	%rax, %r14
               	shlq	$0x2, %r14
               	addq	%r14, %r12
               	movslq	(%r12), %r12
               	addq	$0x3e8, %rax            # imm = 0x3E8
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	movslq	-0x428(%rbp), %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r12
               	addq	$0xb4, %r12
               	movslq	-0x428(%rbp), %rax
               	movq	%rax, %r14
               	shlq	$0x2, %r14
               	addq	%r14, %r12
               	movslq	(%r12), %r12
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movslq	-0x428(%rbp), %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %r12
               	addq	$0x158, %r12            # imm = 0x158
               	movslq	-0x428(%rbp), %rax
               	movq	%rax, %r14
               	shlq	$0x2, %r14
               	addq	%r14, %r12
               	movslq	(%r12), %r12
               	addq	$0xbb8, %rax            # imm = 0xBB8
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movslq	-0x428(%rbp), %rax
               	addq	$0x6e, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x490, %rsp            # imm = 0x490
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
