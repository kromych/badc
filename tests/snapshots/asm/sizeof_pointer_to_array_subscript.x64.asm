
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
               	movq	(%r11), %r9
               	addq	$0x8, %r9
               	leaq	-0x70(%rbp), %r11
               	movq	(%r11), %r8
               	subq	%r8, %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rax
               	addq	$0x10, %rax
               	leaq	-0x70(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	subq	%r11, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r11
               	addq	$0x20, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r9
               	subq	%r9, %r11
               	cmpq	$0x20, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x18, %r11
               	movq	(%r11), %rax
               	addq	$0x40, %rax
               	leaq	-0x70(%rbp), %r11
               	addq	$0x18, %r11
               	movq	(%r11), %r9
               	subq	%r9, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r9
               	addq	$0x3c, %r9
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r11
               	subq	%r11, %r9
               	cmpq	$0x3c, %r9
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r9
               	addq	$0x20, %r9
               	movq	(%r9), %rax
               	addq	$0x14, %rax
               	leaq	-0x70(%rbp), %r9
               	addq	$0x20, %r9
               	movq	(%r9), %r11
               	subq	%r11, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %r11d
               	movq	%r11, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r11
               	addq	$0x18, %r11
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r9
               	subq	%r9, %r11
               	cmpq	$0x18, %r11
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x28, %r11
               	movq	(%r11), %rax
               	addq	$0xc, %rax
               	leaq	-0x70(%rbp), %r11
               	addq	$0x28, %r11
               	movq	(%r11), %r9
               	subq	%r9, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r9
               	addq	$0x4, %r9
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r11
               	subq	%r11, %r9
               	cmpq	$0x4, %r9
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x8, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	movslq	-0x78(%rbp), %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r11
               	addq	$0x3e8, %r9             # imm = 0x3E8
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	movw	%r9w, (%r11)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x8, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	movslq	-0x78(%rbp), %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r11
               	movswq	(%r11), %rax
               	addq	$0x3e8, %r9             # imm = 0x3E8
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	cmpq	%r9, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	addq	$0x14, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x8, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	movslq	-0x78(%rbp), %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %r11
               	movswq	(%r11), %rax
               	addq	$0x3e8, %r9             # imm = 0x3E8
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	cmpq	%r9, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	addq	$0x1c, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x20, %r9
               	movq	(%r9), %rax
               	movslq	-0x78(%rbp), %r9
               	movl	$0x14, %r11d
               	imulq	%r9, %r11
               	addq	%r11, %rax
               	movslq	-0x80(%rbp), %r11
               	movq	%r11, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	movl	$0x64, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x20, %r9
               	movq	(%r9), %r11
               	movslq	-0x78(%rbp), %r9
               	movl	$0x14, %eax
               	imulq	%r9, %rax
               	addq	%rax, %r11
               	movslq	-0x80(%rbp), %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movslq	(%r11), %rdi
               	movl	$0x64, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	cmpq	%r9, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	movl	$0x5, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	$0x28, %r9
               	movslq	%r9d, %r9
               	movslq	-0x80(%rbp), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x20, %r9
               	movq	(%r9), %rax
               	movslq	-0x78(%rbp), %r9
               	movl	$0x14, %edi
               	imulq	%r9, %rdi
               	addq	%rdi, %rax
               	movslq	-0x80(%rbp), %rdi
               	movq	%rdi, %r11
               	shlq	$0x2, %r11
               	addq	%r11, %rax
               	movslq	(%rax), %r11
               	movl	$0x64, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	cmpq	%r9, %r11
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	movl	$0x5, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	$0x3c, %r9
               	movslq	%r9d, %r9
               	movslq	-0x80(%rbp), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x2, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x28, %r9
               	movq	(%r9), %rdi
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %r11d
               	imulq	%r11, %r9
               	addq	%r9, %rdi
               	movslq	-0x80(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdi
               	movslq	-0x88(%rbp), %r11
               	addq	%r11, %rdi
               	movslq	%r9d, %r9
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x2, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x28, %r9
               	movq	(%r9), %rdi
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %r11d
               	imulq	%r11, %r9
               	addq	%r9, %rdi
               	movslq	-0x80(%rbp), %r11
               	shlq	$0x2, %r11
               	addq	%r11, %rdi
               	movslq	-0x88(%rbp), %rax
               	addq	%rax, %rdi
               	movzbq	(%rdi), %rsi
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	cmpq	%r9, %rsi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	$0x50, %r9
               	movslq	%r9d, %r9
               	movslq	-0x80(%rbp), %rsi
               	shlq	$0x2, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	movslq	-0x88(%rbp), %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x2, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movslq	(%rsi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rsi)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x88(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x88(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	addq	$0x28, %r9
               	movq	(%r9), %rsi
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %r11d
               	imulq	%r11, %r9
               	addq	%r9, %rsi
               	movslq	-0x80(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rsi
               	movslq	-0x88(%rbp), %r11
               	addq	%r11, %rsi
               	movzbq	(%rsi), %rdi
               	movslq	%r9d, %r9
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	cmpq	%r9, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	$0x6e, %r9
               	movslq	%r9d, %r9
               	movslq	-0x80(%rbp), %rdi
               	shlq	$0x2, %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movslq	-0x88(%rbp), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
