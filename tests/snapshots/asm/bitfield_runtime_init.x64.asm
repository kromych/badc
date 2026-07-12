
bitfield_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<build_packed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rcx, %r8
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%r8d, %r8
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdi, %rcx
               	andq	$0xf, %rcx
               	movl	(%rax), %r9d
               	andq	$-0x10, %r9
               	orq	%r9, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xf, %rcx
               	movl	(%rax), %r9d
               	andq	$-0xf1, %r9
               	shlq	$0x4, %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, %rcx
               	andq	$0x1f, %rcx
               	movl	(%rax), %r9d
               	andq	$-0x1f01, %r9           # imm = 0xE0FF
               	shlq	$0x8, %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%r8, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movl	0x4(%rax), %r9d
               	andq	$-0x100000, %r9         # imm = 0xFFF00000
               	orq	%r9, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0xf, %rax
               	movq	%rdi, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	movq	%rsi, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0x1f, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	0x4(%rax), %eax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	movq	%r8, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rcx, %r9
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movw	%di, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	movl	(%rax), %ebx
               	andq	$-0x70001, %rbx         # imm = 0xFFF8FFFF
               	shlq	$0x10, %rcx
               	orq	%rbx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, %rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	movl	(%rax), %ebx
               	andq	$-0x1ff80001, %rbx      # imm = 0xE007FFFF
               	shlq	$0x13, %rcx
               	orq	%rbx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%r9, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	movl	0x4(%rax), %ebx
               	andq	$-0x80000, %rbx         # imm = 0xFFF80000
               	orq	%rbx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%r8d, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzwq	(%rax), %rax
               	movq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	movq	%rdx, %rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %eax
               	andq	$0x7ffff, %rax          # imm = 0x7FFFF
               	movq	%r9, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	%r8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0xa, %esi
               	movabsq	$-0x3, %rdx
               	movl	$0x12345, %ecx          # imm = 0x12345
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	movl	$0x1f, %esi
               	movl	$0xf, %edx
               	movl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$-0x10, %rdx
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1234, %edi           # imm = 0x1234
               	movl	$0x6, %esi
               	movl	$0x1f4, %edx            # imm = 0x1F4
               	movl	$0x186a0, %ecx          # imm = 0x186A0
               	movabsq	$-0x4d, %r8
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	movl	$0x7, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	movl	$0x7ffff, %ecx          # imm = 0x7FFFF
               	movl	$0x7fffffff, %r8d       # imm = 0x7FFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
