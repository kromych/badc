
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	addq	$0x18, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	addq	$0x20, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	addq	$0x40, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x18, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	addq	$0x3c, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	addq	$0x14, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x28, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	addq	$0xc, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x28, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	addq	$0x4, %rax
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x28, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	addq	%rdx, %rax
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	movw	%cx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	addq	%rdx, %rax
               	movswq	(%rax), %rax
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x1, %rdx
               	addq	%rdx, %rax
               	movswq	(%rax), %rax
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0x14, %edx
               	imulq	%rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0x14, %edx
               	imulq	%rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movslq	(%rax), %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0x5, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x28, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0x14, %edx
               	imulq	%rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0x80(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movslq	(%rax), %rax
               	movl	$0x64, %r11d
               	imulq	%r11, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0x5, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0xc, %r11d
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	movslq	-0x80(%rbp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	-0x88(%rbp), %rsi
               	addq	%rsi, %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0xc, %r11d
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	movslq	-0x80(%rbp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	-0x88(%rbp), %rsi
               	addq	%rsi, %rax
               	movzbq	(%rax), %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	-0x88(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %rcx
               	movl	$0xc, %r11d
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	movslq	-0x80(%rbp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movslq	-0x88(%rbp), %rsi
               	addq	%rsi, %rax
               	movzbq	(%rax), %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x6e, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	-0x88(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
