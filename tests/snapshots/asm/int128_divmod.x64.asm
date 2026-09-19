
int128_divmod.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rdi, %rsi
               	orq	%rax, %rsi
               	movq	$-0x1, %rdx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r8
               	movq	(%r8), %r13
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	movq	%rdx, %rbx
               	movq	%rax, %r9
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r9, %r14
               	shrq	$0x3f, %r14
               	movq	%r12, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r15, %r12
               	orq	%r14, %r12
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	testq	%rdi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rdi, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rbx
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rax, %r12
               	shrq	$0x3f, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r13, %r9
               	orq	%r12, %r9
               	movq	%rdx, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rax
               	testq	%rdi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %rdx
               	xorq	$0x1, %rdx
               	xorl	%r12d, %r12d
               	subq	%rdx, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %r9
               	subq	%r14, %rdi
               	orq	%r13, %rdx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x7, %r9
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0x1, %r8d
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %r12
               	movq	%rsi, %r9
               	movq	%rcx, %rbx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rbx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %r12
               	orq	%r12, %rax
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rbx
               	shrq	$0x3f, %r9
               	orq	%r9, %rbx
               	cmpq	$0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorl	%r13d, %r13d
               	subq	%r9, %r13
               	movq	%rdi, %r14
               	andq	%r13, %r14
               	andq	%r8, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rax
               	subq	0x58(%rsp), %rax
               	orq	%r15, %r9
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %r9
               	movq	%rsi, %rbx
               	movq	%rcx, %r12
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %r9
               	orq	%r9, %rax
               	movq	%r14, %r9
               	orq	%r13, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	cmpq	$0x1, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r13d, %r13d
               	subq	%rbx, %r13
               	movq	%rdi, %r14
               	andq	%r13, %r14
               	andq	%r8, %r13
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	%r13, %rax
               	subq	0x58(%rsp), %rax
               	orq	%r15, %rbx
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%r9, %rdx
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	movl	$0x80, %r9d
               	movq	%rax, %r12
               	movq	%rax, %rbx
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rbx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %r12
               	orq	%r12, %rax
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%rdx, %r15
               	shlq	%r15
               	shlq	%rbx
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rbx
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %rdx
               	xorq	$0x1, %rdx
               	xorl	%r13d, %r13d
               	subq	%rdx, %r13
               	movq	%rdi, %r14
               	andq	%r13, %r14
               	andq	%r8, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rax
               	subq	0x58(%rsp), %rax
               	orq	%r15, %rdx
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r9
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %rbx
               	movq	%rax, %r12
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%rbx, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rax
               	movq	%r14, %rbx
               	orq	%r13, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	cmpq	$0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %rbx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorl	%r13d, %r13d
               	subq	%r9, %r13
               	movq	%rdi, %r14
               	andq	%r13, %r14
               	andq	%r8, %r13
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %rbx
               	subq	%r13, %rax
               	subq	0x58(%rsp), %rax
               	orq	%r15, %r9
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rbx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	$-0x1, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %rdx     # imm = 0x3000000000
               	xorl	%eax, %eax
               	movl	$0x80, %ebx
               	movq	%rax, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %r12
               	orq	%r12, %rax
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rdx
               	shrq	$0x3f, %r9
               	orq	%r9, %rdx
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorl	%r13d, %r13d
               	subq	%r9, %r13
               	andq	$0x7, %r13
               	cmpq	%r13, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r13, %r12
               	subq	%r15, %rax
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	movq	%rdx, %rbx
               	xorq	$-0x1, %rbx
               	movq	0x58(%rsp), %rdx
               	cmpq	%rdx, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	leaq	0x1(%r9), %r14
               	leaq	0x1(%rbx), %r9
               	movq	%r9, %rbx
               	subq	%r13, %rbx
               	movabsq	$-0x6db6db6db6db749a, %r11 # imm = 0x9249249249248B66
               	movq	%r14, %rax
               	cmpq	%r11, %r14
               	jne	<addr>
               	movabsq	$-0x6db6db6dc, %r11     # imm = 0xFFFFFFF924924924
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	$-0x1, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %rdx     # imm = 0x3000000000
               	xorl	%eax, %eax
               	movl	$0x80, %ebx
               	movq	%rax, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rax
               	shrq	$0x3f, %r12
               	orq	%r12, %rax
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rdx
               	shrq	$0x3f, %r9
               	orq	%r9, %rdx
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x7, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r13
               	orq	%r13, %r9
               	xorq	$0x1, %r9
               	xorl	%r13d, %r13d
               	subq	%r9, %r13
               	andq	$0x7, %r13
               	cmpq	%r13, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r13, %r12
               	subq	%r15, %rax
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	0x58(%rsp), %rdx
               	movq	%r12, %r9
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %rax
               	cmpq	%rdx, %r9
               	setb	%dl
               	movzbq	%dl, %rdx
               	incq	%r9
               	incq	%rax
               	subq	%rdx, %rax
               	cmpq	$-0x3, %r9
               	jne	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movl	$0x3039, %edx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rax
               	orq	%rax, %rbx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%rdx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rdx
               	orq	%rdx, %r9
               	cmpq	$0x40, %rbx
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rdx
               	xorq	$0x1, %rdx
               	xorl	%r14d, %r14d
               	subq	%rdx, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %rdx
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%rdx, %rdx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r12, %r9
               	movl	$0xc0000000, %r11d      # imm = 0xC0000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %rdx     # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%rdx, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rax
               	orq	%rax, %rbx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdx
               	shrq	$0x3f, %r9
               	orq	%r9, %rdx
               	cmpq	$0x40, %rbx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r9
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	$-0x1, %rax
               	movq	%rbx, %rdx
               	xorq	$-0x1, %rdx
               	cmpq	$-0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%rax
               	incq	%rdx
               	subq	%r9, %rdx
               	cmpq	$-0x3039, %rax          # imm = 0xCFC7
               	jne	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%edx, %edx
               	movl	$0x80, %r12d
               	movq	%rdx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rdx
               	shrq	$0x3f, %rax
               	orq	%rax, %rdx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%rbx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	cmpq	$0x40, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x40, %rdx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rdx
               	subq	%r15, %rdx
               	orq	%r13, %rbx
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	$-0x1, %rbx
               	xorq	$-0x1, %r9
               	cmpq	$-0x1, %rbx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	incq	%rbx
               	incq	%r9
               	negq	%r12
               	addq	%r9, %r12
               	movabsq	$-0xc0000000, %r11      # imm = 0xFFFFFFFF40000000
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	jne	<addr>
               	cmpq	$-0x1, %r12
               	je	<addr>
               	movl	$0xb, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%edx, %edx
               	movl	$0x80, %r12d
               	movq	%rdx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rdx
               	shrq	$0x3f, %rax
               	orq	%rax, %rdx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%rbx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	cmpq	$0x40, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x40, %rdx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rdx
               	subq	%r15, %rdx
               	orq	%r13, %rbx
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%r9, %rdx
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %rbx
               	movq	%rsi, %r9
               	movq	%rcx, %r12
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%rax
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rax
               	movq	%r15, %rbx
               	orq	%r14, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %rbx
               	subq	0x58(%rsp), %rax
               	orq	%r15, %r9
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	xorl	%ebx, %ebx
               	movq	%r9, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%r9d, %r13d
               	movq	%r9, %r14
               	shrq	$0x20, %r14
               	movl	%eax, %r15d
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r13, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	%r14, %r15
               	addq	0x40(%rsp), %r15
               	movl	%r15d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movq	%r15, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x58(%rsp), %r15
               	imulq	%r15, %r13
               	addq	0x40(%rsp), %r13
               	shrq	$0x20, %r13
               	imulq	%r15, %r14
               	addq	0x38(%rsp), %r14
               	addq	%r14, %r13
               	imulq	%rbx, %r9
               	imulq	%r12, %rax
               	addq	%r13, %r9
               	leaq	(%r9,%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	(%rdx), %r13
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %r9
               	movq	%rsi, %rbx
               	movq	%rcx, %r12
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rax
               	shrq	$0x3f, %r9
               	orq	%r9, %rax
               	movq	%r15, %r9
               	orq	%r14, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	testq	%rax, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rax, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%r13, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	andq	0x58(%rsp), %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	%r13, %r14
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	0x58(%rsp), %rax
               	orq	%r15, %rbx
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x48(%rsp), %rdx
               	addq	%rdx, %r9
               	cmpq	%rdx, %r9
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rdx, %rax
               	movq	%rsi, %rdx
               	xorq	%r9, %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %edx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rax
               	orq	%rax, %rbx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%rdx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rdx
               	orq	%rdx, %r9
               	cmpq	$0x40, %rbx
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rdx
               	xorq	$0x1, %rdx
               	xorl	%r14d, %r14d
               	subq	%rdx, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %rdx
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%rdx, %rdx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r9, %r14
               	subq	%r12, %r14
               	movq	0x50(%rsp), %rax
               	movq	%rdx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%edx, %r9d
               	movq	%rdx, %rbx
               	shrq	$0x20, %rbx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	movq	%r9, %r15
               	imulq	%r12, %r15
               	shrq	$0x20, %r15
               	imulq	%rbx, %r12
               	addq	%r15, %r12
               	movl	%r12d, %r15d
               	shrq	$0x20, %r12
               	imulq	%r13, %r9
               	addq	%r15, %r9
               	shrq	$0x20, %r9
               	imulq	%r13, %rbx
               	addq	%r12, %rbx
               	addq	%rbx, %r9
               	imulq	$-0x40, %rdx, %rdx
               	imulq	%r14, %rax
               	addq	%r9, %rdx
               	leaq	(%rdx,%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %rdx     # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rax
               	testq	%r12, %r12
               	je	<addr>
               	movq	%rdx, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rax
               	orq	%rax, %rbx
               	movq	%r14, %rax
               	orq	%r13, %rax
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdx
               	shrq	$0x3f, %r9
               	orq	%r9, %rdx
               	cmpq	$0x40, %rbx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%rax, %rax
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r9
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	$-0x1, %rax
               	movq	%rbx, %rdx
               	xorq	$-0x1, %rdx
               	cmpq	$-0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	leaq	0x1(%rax), %rbx
               	leaq	0x1(%rdx), %rax
               	negq	%r9
               	addq	%rax, %r9
               	movq	0x58(%rsp), %rax
               	leaq	(%rax,%rbx), %rdx
               	cmpq	%rax, %rdx
               	setb	%al
               	movzbq	%al, %rax
               	movq	%r9, %r10
               	movq	0x50(%rsp), %r9
               	addq	%r10, %r9
               	addq	%r9, %rax
               	xorq	$-0x3039, %rdx          # imm = 0xCFC7
               	movabsq	$-0x3000000001, %r11    # imm = 0xFFFFFFCFFFFFFFFF
               	xorq	%r11, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rsi, %r9
               	movq	%rax, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %r12
               	shrq	$0x3f, %r12
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r13, %rsi
               	orq	%r12, %rsi
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %r9
               	xorq	$0x1, %r9
               	xorl	%r12d, %r12d
               	subq	%r9, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rsi
               	subq	%r14, %rax
               	orq	%r13, %r9
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movq	%rax, %rsi
               	movq	%r9, %rbx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%r9, %rsi
               	movq	%rbx, %r13
               	shlq	%r13
               	shlq	%rcx
               	movq	%rbx, %r9
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	cmpq	$0x1, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	xorl	%ebx, %ebx
               	subq	%r9, %rbx
               	movq	%rdi, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	movq	%r13, %rbx
               	orq	%r9, %rbx
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rcx # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r9, %rax
               	mulq	%rcx
               	movq	%rdx, %rbx
               	shrq	%rbx
               	movq	%rbx, %rax
               	imulq	%rdi, %rax
               	movq	%r9, %rsi
               	subq	%rax, %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %r9
               	movq	%r9, %rax
               	imulq	%rbx, %rax
               	subq	%rax, %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	imulq	%r13, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %r12
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r9
               	movq	%r9, %rax
               	imulq	%r13, %rax
               	movq	%rsi, %rbx
               	subq	%rax, %rbx
               	xorl	%eax, %eax
               	movq	%rax, %r12
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r9 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%r9
               	movq	%rdx, %rbx
               	shrq	%rbx
               	movq	%rbx, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %r12
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r9 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%r9
               	movq	%rdx, %r9
               	shrq	%r9
               	movq	%r9, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %r12
               	subq	%rax, %r12
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
