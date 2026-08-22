
gcc_atomics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0xa, %eax
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movl	$0x14, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x14, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	movl	$0x1e, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x1e, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x64, %eax
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x5, %esi
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x69, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	%esi, (%rcx)
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x69, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x6, %esi
               	movl	%esi, (%rcx)
               	movl	$0xf0, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0x3c, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xf0, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x30, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0xf, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rax, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x30, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x3f, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x8, %esi
               	movl	%esi, (%rcx)
               	movl	$0xff, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x3f, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0xc0, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x9, %esi
               	movl	%esi, (%rcx)
               	movl	$0x7, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x8, %edi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rdi, %r10
               	movq	%rsi, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rdx
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa, %edx
               	movl	%edx, (%rax)
               	movl	%ecx, -0x30(%rbp)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x9, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rax, %r10
               	movq	%rsi, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x30(%rbp), %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xb, %esi
               	movl	%esi, (%rcx)
               	movl	$0x64, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0x7, %edi
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rdi, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x64, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x6b, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xc, %esi
               	movl	%esi, (%rcx)
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rdi, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	subq	$0x7, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x64, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x64, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xd, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x1, %eax
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rax, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x65, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x65, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xe, %esi
               	movl	%esi, (%rcx)
               	movl	$0xcc, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0x33, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xcc, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0xff, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xf, %esi
               	movl	%esi, (%rcx)
               	movl	$0xf, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	andq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xf, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0xf, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x10, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0xff, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	xorq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xf0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0xf0, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x11, %esi
               	movl	%esi, (%rcx)
               	movl	$0x5, %esi
               	movl	%esi, -0x38(%rbp)
               	movl	$0x6, %edi
               	leaq	-0x20(%rbp), %rcx
               	movl	%esi, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rdi, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rsi
               	movslq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x6, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x12, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x5, %ecx
               	movl	$0x7, %esi
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, (%rax)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x6, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x13, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x8, %esi
               	leaq	-0x10(%rbp), %rcx
               	movl	%edi, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x14, %esi
               	movl	%esi, (%rcx)
               	movl	$0x6, %esi
               	movl	$0x9, %edi
               	leaq	-0x8(%rbp), %rcx
               	movl	%esi, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rdi, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x15, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %esi
               	movl	%esi, -0x38(%rbp)
               	movl	$0x2, %eax
               	movq	%rdx, %r11
               	movq	%rax, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x16, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movq	%rax, %rcx
               	movb	%al, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	%rsi, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rdx
               	andq	$0xff, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x18, %edx
               	movl	%edx, (%rax)
               	movl	$0x1, %eax
               	movq	%rcx, %r11
               	movq	%rax, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x19, %edx
               	movl	%edx, (%rax)
               	xorq	%rax, %rax
               	movb	%al, (%rcx)
               	mfence
               	mfence
               	mfence
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
