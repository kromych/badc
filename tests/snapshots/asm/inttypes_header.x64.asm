
inttypes_header.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	movabsq	$-0x4, %r11
               	movq	%r11, -0x20(%rbp)
               	movl	$0x4, %r9d
               	movq	%r9, -0x40(%rbp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %r8
               	movq	%r8, -0xb0(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %r8
               	movq	%r8, -0xc8(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe8(%rbp), %r8
               	movq	%r8, -0xe0(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x78, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xf0(%rbp)
               	jmp	<addr>
               	movq	-0xf0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x108(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x68, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x108(%rbp)
               	jmp	<addr>
               	movq	-0x108(%rbp), %r8
               	movq	%r8, -0x100(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x100(%rbp)
               	jmp	<addr>
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0xf8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xf8(%rbp)
               	jmp	<addr>
               	movq	-0xf8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x118(%rbp)
               	jmp	<addr>
               	movq	-0x118(%rbp), %r8
               	movq	%r8, -0x110(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x110(%rbp)
               	jmp	<addr>
               	movq	-0x110(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x130(%rbp)
               	jmp	<addr>
               	movq	-0x130(%rbp), %r8
               	movq	%r8, -0x128(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x128(%rbp)
               	jmp	<addr>
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x120(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x120(%rbp)
               	jmp	<addr>
               	movq	-0x120(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x148(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x6c, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x148(%rbp)
               	jmp	<addr>
               	movq	-0x148(%rbp), %r8
               	movq	%r8, -0x140(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x140(%rbp)
               	jmp	<addr>
               	movq	-0x140(%rbp), %rax
               	movq	%rax, -0x138(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x138(%rbp)
               	jmp	<addr>
               	movq	-0x138(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x25, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
