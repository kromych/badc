
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
               	leaq	-0x70(%rbp), %r11
               	leaq	<rip>, %r9
               	movq	%r9, (%r11)
               	leaq	-0x70(%rbp), %r8
               	addq	$0x8, %r8
               	leaq	<rip>, %r9
               	movq	%r9, (%r8)
               	leaq	-0x70(%rbp), %r11
               	addq	$0x10, %r11
               	leaq	<rip>, %r9
               	movq	%r9, (%r11)
               	leaq	-0x70(%rbp), %r8
               	addq	$0x18, %r8
               	leaq	<rip>, %r9
               	movq	%r9, (%r8)
               	leaq	-0x70(%rbp), %r11
               	addq	$0x20, %r11
               	leaq	<rip>, %r9
               	movq	%r9, (%r11)
               	leaq	-0x70(%rbp), %r8
               	addq	$0x28, %r8
               	leaq	<rip>, %r9
               	movq	%r9, (%r8)
               	leaq	-0x70(%rbp), %r11
               	movq	(%r11), %r11
               	addq	$0x8, %r11
               	leaq	-0x70(%rbp), %r9
               	movq	(%r9), %r9
               	subq	%r9, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	addq	$0x10, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x10, %r11
               	movq	(%r11), %r11
               	addq	$0x20, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x20, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x18, %r11
               	movq	(%r11), %r11
               	addq	$0x40, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x40, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x20, %r11
               	movq	(%r11), %r11
               	addq	$0x3c, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x3c, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x20, %r11
               	movq	(%r11), %r11
               	addq	$0x14, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x28, %r11
               	movq	(%r11), %r11
               	addq	$0x18, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x18, %r11
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x28, %r11
               	movq	(%r11), %r11
               	addq	$0xc, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0xc, %r11
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x28, %r11
               	movq	(%r11), %r11
               	addq	$0x4, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movl	%r11d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	cmpq	$0x8, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movslq	-0x78(%rbp), %r8
               	movq	%r8, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r11
               	addq	$0x3e8, %r8             # imm = 0x3E8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	movw	%r8w, (%r11)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r8
               	movslq	-0x78(%rbp), %r11
               	movq	%r11, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r8
               	movswq	(%r8), %r8
               	addq	$0x3e8, %r11            # imm = 0x3E8
               	movslq	%r11d, %r11
               	movswq	%r11w, %r11
               	cmpq	%r11, %r8
               	je	<addr>
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	cmpq	$0x8, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movslq	-0x78(%rbp), %r8
               	movq	%r8, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r11
               	movswq	(%r11), %r11
               	addq	$0x3e8, %r8             # imm = 0x3E8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	cmpq	%r8, %r11
               	je	<addr>
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r8
               	addq	$0x1c, %r8
               	movslq	%r8d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rax)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r8
               	cmpq	$0x5, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r8
               	addq	$0x20, %r8
               	movq	(%r8), %r8
               	movslq	-0x78(%rbp), %rax
               	movl	$0x14, %r11d
               	imulq	%rax, %r11
               	addq	%r11, %r8
               	movslq	-0x80(%rbp), %r11
               	movq	%r11, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movl	$0x64, %r10d
               	imulq	%r10, %rax
               	movslq	%eax, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r11
               	movslq	(%r11), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r11)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movslq	(%r8), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r8)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %r11
               	movl	$0x14, %r8d
               	imulq	%r11, %r8
               	addq	%r8, %rax
               	movslq	-0x80(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	movslq	(%rax), %rax
               	movl	$0x64, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	movl	$0x5, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x28, %r11
               	movslq	%r11d, %r11
               	movslq	-0x80(%rbp), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	cmpq	$0x3, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rax)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r11
               	addq	$0x20, %r11
               	movq	(%r11), %r11
               	movslq	-0x78(%rbp), %rax
               	movl	$0x14, %r8d
               	imulq	%rax, %r8
               	addq	%r8, %r11
               	movslq	-0x80(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movslq	(%r11), %r11
               	movl	$0x64, %r10d
               	imulq	%r10, %rax
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r11
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0x5, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %r11
               	addq	%r11, %rax
               	movslq	%eax, %r11
               	movq	%r11, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r11
               	movslq	(%r11), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r11)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movslq	(%r8), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r8)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %r11
               	movslq	(%r11), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r11)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %r8
               	movl	$0xc, %r11d
               	imulq	%r11, %r8
               	addq	%r8, %rax
               	movslq	-0x80(%rbp), %r11
               	shlq	$0x2, %r11
               	addq	%r11, %rax
               	movslq	-0x88(%rbp), %rdi
               	addq	%rdi, %rax
               	movslq	%r8d, %r8
               	movslq	%r11d, %r11
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x2, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rax)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r8
               	addq	$0x28, %r8
               	movq	(%r8), %r8
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %r11d
               	imulq	%r11, %rax
               	addq	%rax, %r8
               	movslq	-0x80(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movslq	-0x88(%rbp), %r11
               	addq	%r11, %r8
               	movzbq	(%r8), %r8
               	movslq	%eax, %rax
               	movslq	%edi, %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %r8
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movslq	-0x88(%rbp), %r8
               	addq	%r8, %rax
               	movslq	%eax, %r8
               	movq	%r8, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r8)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x80(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movslq	(%r11), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r11)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %r8
               	movslq	(%r8), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r8)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movslq	-0x78(%rbp), %r11
               	movl	$0xc, %r10d
               	imulq	%r10, %r11
               	addq	%r11, %rax
               	movslq	-0x80(%rbp), %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	-0x88(%rbp), %rdi
               	addq	%rdi, %rax
               	movzbq	(%rax), %rax
               	movslq	%r11d, %r11
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	andq	$0xff, %r11
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r11
               	movl	$0xc, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x6e, %r11
               	movslq	%r11d, %r11
               	movslq	-0x80(%rbp), %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %r11
               	movslq	%r11d, %r11
               	movslq	-0x88(%rbp), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
