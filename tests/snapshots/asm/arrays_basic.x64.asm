
arrays_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%esi, %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	movslq	%eax, %rdx
               	movslq	%ecx, %r8
               	movq	%r8, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	addq	$0x1, %r8
               	movslq	%r8d, %rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rax
               	movl	%eax, (%rdx)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	imulq	$0xa, %rsi, %rsi
               	movslq	%esi, %rax
               	movl	%eax, (%rdx)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x10, %rdx
               	movslq	(%rdx), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x68, %edx
               	movb	%dl, (%rax)
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movl	$0x69, %esi
               	movb	%sil, (%rdx)
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movb	%cl, (%rdx)
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	movl	%eax, (%rsi)
               	leaq	-0x40(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rdx
               	addq	$0x4, %rdx
               	imulq	$0x64, %rsi, %rsi
               	movslq	%esi, %rax
               	movl	%eax, (%rdx)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x14, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x68(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	leaq	-0x68(%rbp), %rdx
               	addq	$0x20, %rdx
               	movslq	(%rdx), %rdi
               	leaq	-0x68(%rbp), %rsi
               	movslq	%ecx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	addq	%rdx, %rdi
               	movslq	%edi, %rdx
               	movl	%edx, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x24, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	addq	$0x41, %rsi
               	movslq	%esi, %rdx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x7, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x48, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rdx
               	movq	%rcx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
