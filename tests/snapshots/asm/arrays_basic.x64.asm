
arrays_basic.x64:	file format elf64-x86-64

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
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	<addr>
               	movslq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%r11, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x8(%rbp)
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	<addr>
               	leaq	-0x18(%rbp), %r9
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%r9)
               	movslq	-0x20(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	movl	$0xa, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rdi)
               	movslq	-0x20(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x20(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movslq	(%r9), %rax
               	movq	%r9, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%r9, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%r9, %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%r9, %r9
               	movl	$0x68, %edi
               	movb	%dil, (%rax)
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movl	$0x69, %edi
               	movb	%dil, (%r8)
               	movq	%rax, %r11
               	addq	$0x2, %r11
               	movb	%r9b, (%r11)
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %r11
               	shlq	$0x3, %r11
               	addq	%r11, %rdi
               	movl	%eax, (%rdi)
               	leaq	-0x40(%rbp), %r11
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r11
               	addq	$0x4, %r11
               	movl	$0x64, %r10d
               	imulq	%r10, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r11)
               	movslq	-0x20(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	xorq	%rdi, %rdi
               	movl	%edi, (%rax)
               	movl	%edi, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rdi
               	cmpq	$0x8, %rdi
               	jge	<addr>
               	leaq	-0x68(%rbp), %r11
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r11
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r11)
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	leaq	-0x68(%rbp), %rdi
               	addq	$0x20, %rdi
               	movslq	(%rdi), %rdi
               	leaq	-0x68(%rbp), %r11
               	movslq	-0x20(%rbp), %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rax)
               	movslq	-0x20(%rbp), %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x68(%rbp), %r11
               	addq	$0x20, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x24, %r11
               	je	<addr>
               	movl	$0xd, %edi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x8, %r11
               	jge	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movslq	-0x20(%rbp), %r11
               	addq	%r11, %rdi
               	addq	$0x41, %r11
               	movslq	%r11d, %r11
               	movb	%r11b, (%rdi)
               	movslq	-0x20(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x7, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x48, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %r11d
               	movq	%r11, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
