
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x470, %rsp            # imm = 0x470
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
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x420(%rbp), %rax
               	leaq	-0x210(%rbp), %rdx
               	pushq	%r11
               	movq	(%rdx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rdx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rdx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rdx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rdx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rdx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rdx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rdx), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%rdx), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%rdx), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%rdx), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%rdx), %r11
               	movq	%r11, 0x58(%rax)
               	movq	0x60(%rdx), %r11
               	movq	%r11, 0x60(%rax)
               	movq	0x68(%rdx), %r11
               	movq	%r11, 0x68(%rax)
               	movq	0x70(%rdx), %r11
               	movq	%r11, 0x70(%rax)
               	movq	0x78(%rdx), %r11
               	movq	%r11, 0x78(%rax)
               	movq	0x80(%rdx), %r11
               	movq	%r11, 0x80(%rax)
               	movq	0x88(%rdx), %r11
               	movq	%r11, 0x88(%rax)
               	movq	0x90(%rdx), %r11
               	movq	%r11, 0x90(%rax)
               	movq	0x98(%rdx), %r11
               	movq	%r11, 0x98(%rax)
               	movq	0xa0(%rdx), %r11
               	movq	%r11, 0xa0(%rax)
               	movq	0xa8(%rdx), %r11
               	movq	%r11, 0xa8(%rax)
               	movq	0xb0(%rdx), %r11
               	movq	%r11, 0xb0(%rax)
               	movq	0xb8(%rdx), %r11
               	movq	%r11, 0xb8(%rax)
               	movq	0xc0(%rdx), %r11
               	movq	%r11, 0xc0(%rax)
               	movq	0xc8(%rdx), %r11
               	movq	%r11, 0xc8(%rax)
               	movq	0xd0(%rdx), %r11
               	movq	%r11, 0xd0(%rax)
               	movq	0xd8(%rdx), %r11
               	movq	%r11, 0xd8(%rax)
               	movq	0xe0(%rdx), %r11
               	movq	%r11, 0xe0(%rax)
               	movq	0xe8(%rdx), %r11
               	movq	%r11, 0xe8(%rax)
               	movq	0xf0(%rdx), %r11
               	movq	%r11, 0xf0(%rax)
               	movq	0xf8(%rdx), %r11
               	movq	%r11, 0xf8(%rax)
               	movq	0x100(%rdx), %r11
               	movq	%r11, 0x100(%rax)
               	movq	0x108(%rdx), %r11
               	movq	%r11, 0x108(%rax)
               	movq	0x110(%rdx), %r11
               	movq	%r11, 0x110(%rax)
               	movq	0x118(%rdx), %r11
               	movq	%r11, 0x118(%rax)
               	movq	0x120(%rdx), %r11
               	movq	%r11, 0x120(%rax)
               	movq	0x128(%rdx), %r11
               	movq	%r11, 0x128(%rax)
               	movq	0x130(%rdx), %r11
               	movq	%r11, 0x130(%rax)
               	movq	0x138(%rdx), %r11
               	movq	%r11, 0x138(%rax)
               	movq	0x140(%rdx), %r11
               	movq	%r11, 0x140(%rax)
               	movq	0x148(%rdx), %r11
               	movq	%r11, 0x148(%rax)
               	movq	0x150(%rdx), %r11
               	movq	%r11, 0x150(%rax)
               	movq	0x158(%rdx), %r11
               	movq	%r11, 0x158(%rax)
               	movq	0x160(%rdx), %r11
               	movq	%r11, 0x160(%rax)
               	movq	0x168(%rdx), %r11
               	movq	%r11, 0x168(%rax)
               	movq	0x170(%rdx), %r11
               	movq	%r11, 0x170(%rax)
               	movq	0x178(%rdx), %r11
               	movq	%r11, 0x178(%rax)
               	movq	0x180(%rdx), %r11
               	movq	%r11, 0x180(%rax)
               	movq	0x188(%rdx), %r11
               	movq	%r11, 0x188(%rax)
               	movq	0x190(%rdx), %r11
               	movq	%r11, 0x190(%rax)
               	movq	0x198(%rdx), %r11
               	movq	%r11, 0x198(%rax)
               	movq	0x1a0(%rdx), %r11
               	movq	%r11, 0x1a0(%rax)
               	movq	0x1a8(%rdx), %r11
               	movq	%r11, 0x1a8(%rax)
               	movq	0x1b0(%rdx), %r11
               	movq	%r11, 0x1b0(%rax)
               	movq	0x1b8(%rdx), %r11
               	movq	%r11, 0x1b8(%rax)
               	movq	0x1c0(%rdx), %r11
               	movq	%r11, 0x1c0(%rax)
               	movq	0x1c8(%rdx), %r11
               	movq	%r11, 0x1c8(%rax)
               	movq	0x1d0(%rdx), %r11
               	movq	%r11, 0x1d0(%rax)
               	movq	0x1d8(%rdx), %r11
               	movq	%r11, 0x1d8(%rax)
               	movq	0x1e0(%rdx), %r11
               	movq	%r11, 0x1e0(%rax)
               	movq	0x1e8(%rdx), %r11
               	movq	%r11, 0x1e8(%rax)
               	movq	0x1f0(%rdx), %r11
               	movq	%r11, 0x1f0(%rax)
               	movq	0x1f8(%rdx), %r11
               	movq	%r11, 0x1f8(%rax)
               	movq	0x200(%rdx), %r11
               	movq	%r11, 0x200(%rax)
               	movzbq	0x208(%rdx), %r11
               	movb	%r11b, 0x208(%rax)
               	movzbq	0x209(%rdx), %r11
               	movb	%r11b, 0x209(%rax)
               	movzbq	0x20a(%rdx), %r11
               	movb	%r11b, 0x20a(%rax)
               	movzbq	0x20b(%rdx), %r11
               	movb	%r11b, 0x20b(%rax)
               	popq	%r11
               	leaq	-0x420(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x458(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xc8, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x458(%rbp)
               	jmp	<addr>
               	movq	-0x458(%rbp), %rdx
               	movq	%rdx, -0x450(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x450(%rbp)
               	jmp	<addr>
               	movq	-0x450(%rbp), %rax
               	movq	%rax, -0x448(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rdx
               	addq	$0xc, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x190, %rdx            # imm = 0x190
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x448(%rbp)
               	jmp	<addr>
               	movq	-0x448(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rdx
               	addq	$0x1fc, %rdx            # imm = 0x1FC
               	movslq	(%rdx), %rdx
               	cmpq	$0x1f4, %rdx            # imm = 0x1F4
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x470(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movslq	(%rax), %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x470(%rbp)
               	jmp	<addr>
               	movq	-0x470(%rbp), %rax
               	movq	%rax, -0x468(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x420(%rbp), %rdx
               	addq	$0x204, %rdx            # imm = 0x204
               	movslq	(%rdx), %rdx
               	cmpq	$0x2bc, %rdx            # imm = 0x2BC
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x468(%rbp)
               	jmp	<addr>
               	movq	-0x468(%rbp), %rdx
               	movq	%rdx, -0x460(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x420(%rbp), %rax
               	addq	$0x208, %rax            # imm = 0x208
               	movslq	(%rax), %rax
               	cmpq	$0x320, %rax            # imm = 0x320
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x460(%rbp)
               	jmp	<addr>
               	movq	-0x460(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %edx
               	movq	%rdx, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0xb0, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0x154, %rax            # imm = 0x154
               	movslq	(%rax), %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %edx
               	movq	%rdx, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0x1f8, %rax            # imm = 0x1F8
               	movslq	(%rax), %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x428(%rbp)
               	jmp	<addr>
               	movslq	-0x428(%rbp), %rax
               	cmpq	$0x28, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x428(%rbp), %rdx
               	movslq	(%rdx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	leaq	-0x420(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	-0x428(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	(%rax), %rax
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	movslq	-0x428(%rbp), %rsi
               	addq	$0xa, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0xb4, %rax
               	movslq	-0x428(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	(%rax), %rax
               	addq	$0x7d0, %rsi            # imm = 0x7D0
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movslq	-0x428(%rbp), %rsi
               	addq	$0x3c, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	leaq	-0x420(%rbp), %rax
               	addq	$0x158, %rax            # imm = 0x158
               	movslq	-0x428(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	(%rax), %rax
               	addq	$0xbb8, %rsi            # imm = 0xBB8
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movslq	-0x428(%rbp), %rsi
               	addq	$0x6e, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	addq	$0x470, %rsp            # imm = 0x470
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
