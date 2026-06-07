
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
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rcx
               	addq	$0x10, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rcx
               	addq	$0x40, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x40, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rcx
               	addq	$0x3c, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rcx
               	addq	$0x14, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x18, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rcx
               	addq	$0xc, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rcx
               	addq	$0x4, %rcx
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %rdx
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movslq	%esi, %rax
               	movswq	%ax, %rax
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %rdx
               	movswq	(%rdx), %rax
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movslq	%esi, %rdx
               	movswq	%dx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	addq	%rax, %rdx
               	movswq	(%rdx), %rax
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movslq	%esi, %rdx
               	movswq	%dx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rsi
               	movslq	%ecx, %r8
               	imulq	$0x14, %r8, %rax
               	addq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x64, %r8, %r8
               	movslq	%r8d, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rsi
               	movslq	%ecx, %r8
               	imulq	$0x14, %r8, %rax
               	addq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	imulq	$0x64, %r8, %r8
               	movslq	%r8d, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0x5, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x28, %rax
               	movslq	%eax, %rcx
               	movslq	%edx, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rsi
               	movslq	%ecx, %r8
               	imulq	$0x14, %r8, %rax
               	addq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	imulq	$0x64, %r8, %r8
               	movslq	%r8d, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0x5, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rcx
               	movslq	%edx, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rdi
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	addq	%rax, %rdi
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	movslq	%esi, %r9
               	addq	%r9, %rdi
               	movslq	%eax, %r11
               	movslq	%r8d, %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rdi
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	addq	%rax, %rdi
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	movslq	%esi, %r9
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movslq	%eax, %r11
               	movslq	%r8d, %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rax
               	movslq	%eax, %rcx
               	movslq	%edx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%esi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rdi
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	addq	%rax, %rdi
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	movslq	%esi, %r9
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	movslq	%eax, %r11
               	movslq	%r8d, %rax
               	addq	%rax, %r11
               	movslq	%r11d, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x6e, %rax
               	movslq	%eax, %rcx
               	movslq	%edx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%esi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
