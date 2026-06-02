
alloca_basic.x64:	file format elf64-x86-64

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
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x20, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x28(%rbp), %r10
               	movq	(%r10), %r9
               	subq	%r11, %r9
               	movq	%r9, (%r10)
               	movq	%r9, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movl	$0x55, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x10(%rbp), %rdi
               	addq	%rdi, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x55, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	jmp	<addr>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %rdi
               	movl	%edi, 0x10(%rbp)
               	movslq	0x10(%rbp), %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x20(%rbp), %r10
               	movq	(%r10), %rdi
               	subq	%r11, %rdi
               	movq	%rdi, (%r10)
               	movq	%rdi, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %rdi
               	cmpq	%rdi, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r9
               	movl	$0x7, %r11d
               	imulq	%r11, %r8
               	movslq	%r8d, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	movslq	0x10(%rbp), %rdi
               	cmpq	%rdi, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	-0x8(%rbp), %rdi
               	movslq	-0x10(%rbp), %r11
               	shlq	$0x2, %r11
               	addq	%r11, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x10, %r11d
               	movq	%r11, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r9
               	subq	%r10, %r9
               	movq	%r9, (%rax)
               	movq	%r9, -0x8(%rbp)
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x30(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x10(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %r8
               	cmpq	%r8, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movl	$0x41, %esi
               	movl	$0x10, %ebx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x10(%rbp), %rdi
               	movl	$0x42, %esi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rsi
               	addq	$0xf, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x41, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x2038(%rbp)
               	jmp	<addr>
               	movq	-0x2038(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x42, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x2040(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	jmp	<addr>
               	movq	-0x2040(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %rdi
               	movl	%edi, 0x10(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %rdi
               	cmpq	%rdi, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x20(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x18(%rbp)
               	movq	-0x18(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, (%r9)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	movq	-0x18(%rbp), %r9
               	movq	(%r9), %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	movl	$0x40, %edx
               	movq	%rdx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %r11
               	subq	%r10, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movslq	0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	xorq	%rdi, %rdi
               	movl	%edi, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rdi
               	cmpq	$0x40, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rax)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	movslq	-0x18(%rbp), %rsi
               	addq	%rsi, %rdi
               	movzbq	(%rdi), %rdi
               	movslq	0x10(%rbp), %rsi
               	andq	$0xff, %rsi
               	cmpq	%rsi, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	cmpq	$0xbe, %rdi
               	je	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	movabsq	$-0x2, %rsi
               	movq	%rsi, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x11d, %rax            # imm = 0x11D
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$0x4c9, %rax            # imm = 0x4C9
               	je	<addr>
               	leaq	<rip>, %r12
               	movl	$0x32, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
