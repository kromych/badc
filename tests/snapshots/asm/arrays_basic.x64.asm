
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
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rsi
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
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	leaq	-0x18(%rbp), %rbx
               	movl	$0x5, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	<rip>, %r12
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	addq	%rbx, %r12
               	movl	$0xa, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r12)
               	movslq	-0x20(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	movq	%rbx, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%rbx, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %r12
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	%rbx, %r12
               	addq	$0xc, %r12
               	movslq	(%r12), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rbx
               	movslq	(%rbx), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rdi, %rdi
               	movl	$0x68, %ebx
               	movb	%bl, (%rax)
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	$0x69, %ebx
               	movb	%bl, (%r12)
               	movq	%rax, %rsi
               	addq	$0x2, %rsi
               	movb	%dil, (%rsi)
               	movzbq	(%rax), %rbx
               	xorq	$0x68, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	addq	$0x1, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rbx
               	cmpq	$0x3, %rbx
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	movl	%ebx, (%rax)
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	addq	%rbx, %rsi
               	addq	$0x4, %rsi
               	movl	$0x64, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rsi)
               	movslq	-0x20(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x1, %rbx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rbx
               	addq	$0x14, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xc, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	xorq	%rbx, %rbx
               	movl	%ebx, (%rax)
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rbx
               	cmpq	$0x8, %rbx
               	jge	<addr>
               	leaq	-0x68(%rbp), %rsi
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rsi
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, (%rsi)
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	leaq	-0x68(%rbp), %rbx
               	addq	$0x20, %rbx
               	movslq	(%rbx), %rsi
               	leaq	-0x68(%rbp), %rbx
               	movslq	-0x20(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rbx
               	movslq	(%rbx), %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rax)
               	movslq	-0x20(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rdi
               	addq	$0x20, %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x24, %rsi
               	je	<addr>
               	movl	$0xd, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rsi
               	cmpq	$0x8, %rsi
               	jge	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movslq	-0x20(%rbp), %rsi
               	addq	%rsi, %rdi
               	addq	$0x41, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdi)
               	movslq	-0x20(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movzbq	(%rax), %rsi
               	xorq	$0x41, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rsi
               	addq	$0x7, %rsi
               	movzbq	(%rsi), %rax
               	xorq	$0x48, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rsi
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rbx
               	addq	%rbx, %rsi
               	movslq	%esi, %rsi
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	addq	%rbx, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %rsi
               	cmpq	$0xc, %rsi
               	je	<addr>
               	movl	$0x10, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
