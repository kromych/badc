
int128_scalar_contexts.x64:	file format elf64-x86-64

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

<pointers>:
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	movl	(%rcx,%rdx,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movl	(%rcx,%rdx,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movl	(%rcx,%rdx,4), %edx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movq	(%rax), %rdx
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax,%rdx,4), %edx
               	cmpl	$0x1e, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	subq	%rax, %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3e, %rdi
               	addq	%rdi, %rsi
               	sarq	$0x2, %rsi
               	cmpq	$0x3, %rsi
               	jne	<addr>
               	movq	(%rdx), %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	subq	%rax, %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3e, %rdi
               	addq	%rdi, %rsi
               	sarq	$0x2, %rsi
               	cmpq	$0x3, %rsi
               	jne	<addr>
               	addq	$0x1c, %rax
               	movq	(%rdx), %rsi
               	shlq	$0x2, %rsi
               	subq	%rsi, %rax
               	movl	(%rax), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rdx), %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rcx
               	decq	%rcx
               	shlq	$0x2, %rcx
               	subq	%rcx, %rax
               	movl	(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	$0x21, (%rcx,%rax,4)
               	movl	0xc(%rcx), %eax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	0xc(%rcx), %rsi
               	movl	$0x1e, (%rsi)
               	movq	(%rdx), %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rcx,%rdi), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<scalars>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	shlxq	%rdx, %rcx, %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	movl	$0x40, %edx
               	movq	(%rax), %rsi
               	sarxq	%rsi, %rdx, %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	(%rax), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	(%rax), %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	xorq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movb	%cl, -0x10(%rbp)
               	movb	$0x0, -0xf(%rbp)
               	movl	-0x10(%rbp), %ecx
               	andq	$-0xfe01, %rcx          # imm = 0xFFFF01FF
               	movl	%ecx, -0x10(%rbp)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movzbq	-0xf(%rbp), %rcx
               	andq	$-0x2, %rcx
               	orq	%rcx, %rax
               	movb	%al, -0xf(%rbp)
               	movl	-0x10(%rbp), %eax
               	andq	$-0xfe01, %rax          # imm = 0xFFFF01FF
               	orq	$0x200, %rax            # imm = 0x200
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, %ecx
               	sarq	$0x9, %rcx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	andq	$0x7f, %rcx
               	andq	$-0xfe01, %rax          # imm = 0xFFFF01FF
               	shlq	$0x9, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	cmpb	$0x0, -0x10(%rbp)
               	je	<addr>
               	movzbq	-0xf(%rbp), %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	%eax, %eax
               	sarq	$0x9, %rax
               	andq	$0x7f, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	cmpq	%rcx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rdi
               	subq	%rcx, %rdi
               	movq	%rdx, %rcx
               	subq	%rdx, %rcx
               	subq	%rsi, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	orq	%rax, %rdx
               	movq	%rax, %rsi
               	sarq	%rsi
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	orq	%rsi, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	%rsp, %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
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
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<switches>:
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rcx
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
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rcx
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
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	leaq	0x3(%rdx), %rax
               	cmpq	%rdx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%rsi, %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rcx
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdx, %rdi
               	orq	%rdi, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %rax
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$-0x9, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rsi, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x13, %eax
               	retq
               	cmpq	%rax, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rsi, %rcx
               	orq	%rcx, %rax
               	xorq	$0x1, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x5, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rdx
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rsi
               	leaq	0x3(%rax), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rsi, %rax
               	testq	%rax, %rax
               	setl	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rsi, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	$-0x1, %rsi
               	cmpq	%rsi, %rax
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$-0x9, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%rdi, %r9
               	orq	%r9, %r8
               	xorq	$0x1, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rcx
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rax
               	negq	%rcx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x5, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	-0x5(%rax), %rcx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	testq	%rax, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdx, %rdi
               	orq	%rdi, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %rax
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$-0x9, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rsi, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
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
               	cmpq	$0xa, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	cmpq	%rax, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rsi, %rcx
               	orq	%rcx, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x5, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rdx
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rsi
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$-0x3, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rdi, %rcx
               	orq	%rcx, %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	testq	%rax, %rax
               	setg	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x5, %rcx
               	seta	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	orq	%rdi, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
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
               	movq	%rax, %rdx
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
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	movq	%rdx, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	-0x18(%rbp), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rdx
               	addq	$0x2, %rdx
               	movq	%rdx, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movq	(%rax), %rax
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
               	movb	$0x78, 0x1(%rax)
               	movb	$0x78, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
