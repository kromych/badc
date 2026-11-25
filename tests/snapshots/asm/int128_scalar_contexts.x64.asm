
int128_scalar_contexts.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<scalars>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %ecx
               	movq	<rip>, %rax # <addr>
               	shlxq	%rax, %rcx, %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	movl	$0x40, %edx
               	sarxq	%rax, %rdx, %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	shlxq	%rax, %rcx, %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	movq	<rip>, %rcx # <addr>
               	xorq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	orq	$0x200, %rax            # imm = 0x200
               	movq	%rax, %rcx
               	sarq	$0x9, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	movq	<rip>, %rdx # <addr>
               	shlxq	%rdx, %rcx, %rcx
               	andq	$0x7f, %rcx
               	andq	$-0xfe01, %rax          # imm = 0xFFFF01FF
               	shlq	$0x9, %rcx
               	orq	%rcx, %rax
               	testb	$-0x1, %al
               	je	<addr>
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	sarq	$0x9, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	orq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	orq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %rsi
               	sarq	%rsi
               	shrq	%rax
               	shlq	$0x3f, %rdx
               	orq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	%rsp, %rcx
               	movq	<rip>, %rax # <addr>
               	shlq	$0x2, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq

<switches>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x3(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rax
               	negq	%rcx
               	subq	%rdx, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	setl	%dl
               	movzbq	%dl, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rsi, %rdi
               	orq	%rdi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$-0x9, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rdi, %r8
               	orq	%r8, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x13, %eax
               	retq
               	cmpq	%rax, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rdi
               	orq	%rdi, %rax
               	xorq	$0x1, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x5, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x3(%rax), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	testq	%rax, %rax
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rsi, %rdi
               	orq	%rdi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$-0x9, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rdi, %r8
               	orq	%r8, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %rcx
               	negq	%rcx
               	movq	%rdx, %rax
               	negq	%rax
               	subq	%rsi, %rax
               	cmpq	$0x5, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	$0x5, %rcx
               	subq	%rdx, %rax
               	testq	%rax, %rax
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rsi, %rdi
               	orq	%rdi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$-0x9, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rdi, %r8
               	orq	%r8, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x5(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	cmpq	$0xa, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x15, %eax
               	retq
               	cmpq	$0xa, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	cmpq	%rax, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rdi
               	orq	%rdi, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x5, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rdi
               	orq	%rdi, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x5, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rcx
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x2, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	retq
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	jmp	<addr>

<builtins>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x5, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	<rip>, %rcx # <addr>
               	lock
               	addl	%ecx, (%rax)
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x2, %rcx
               	lock
               	addq	%rcx, (%rax)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movb	$0x78, 0x2(%rax)
               	movw	$0x7878, (%rax)         # imm = 0x7878
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rax
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx,%rax,4), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%r11
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%r11
               	retq
               	popq	%r11
               	jmp	<addr>
               	movq	<rip>, %rsi # <addr>
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdx, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3e, %rdi
               	addq	%rdi, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	shlq	$0x2, %rsi
               	leaq	(%rdx,%rsi), %rax
               	subq	%rdx, %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	addq	$0x1c, %rdx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	subq	%rsi, %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x28, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	decq	%rcx
               	shlq	$0x2, %rcx
               	subq	%rcx, %rax
               	movl	(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x21, (%rcx,%rax,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	0xc(%rcx), %rsi
               	movl	$0x1e, (%rsi)
               	movq	<rip>, %rdi # <addr>
               	shlq	$0x2, %rdi
               	leaq	(%rcx,%rdi), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
