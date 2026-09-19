
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
               	movq	(%rax), %rax
               	xorl	%edi, %edi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rdi, %rdx
               	orq	%rcx, %rdx
               	movq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r8
               	movq	(%r8), %r13
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	movq	%rcx, %r9
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
               	movq	%rcx, %r12
               	shrq	$0x3f, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r13, %r9
               	orq	%r12, %r9
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	testq	%rdi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %rsi
               	xorq	$0x1, %rsi
               	xorl	%r12d, %r12d
               	subq	%rsi, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %r9
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %r9
               	subq	%r14, %rdi
               	orq	%r13, %rsi
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x7, %r9
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %esi
               	movl	$0x1, %edi
               	movq	%rax, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rcx, %r12
               	movq	%rdx, %r9
               	movq	%rax, %rbx
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rbx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rbx
               	shrq	$0x3f, %r9
               	orq	%r9, %rbx
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
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
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%r9, %rcx
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rax, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rcx, %r9
               	movq	%rdx, %rbx
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	movq	%r14, %r9
               	orq	%r13, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	cmpq	$0x1, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rcx
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
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	%r13, %rcx
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r8
               	xorl	%ecx, %ecx
               	movl	$0x80, %r9d
               	movq	%rcx, %r12
               	movq	%rcx, %rbx
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rbx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r8, %r15
               	shlq	%r15
               	shlq	%rbx
               	shrq	$0x3f, %r8
               	orq	%r8, %rbx
               	cmpq	$0x1, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x1, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r8
               	xorq	$0x1, %r8
               	xorl	%r13d, %r13d
               	subq	%r8, %r13
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rcx
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %r8
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x5, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r9
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rcx, %rbx
               	movq	%rcx, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%rbx, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rcx
               	movq	%r14, %rbx
               	orq	%r13, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
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
               	movq	%rsi, %r14
               	andq	%r13, %r14
               	andq	%rdi, %r13
               	cmpq	%r14, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %rbx
               	subq	%r13, %rcx
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rbx
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
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
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%ecx, %ecx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
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
               	subq	%r15, %rcx
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	movq	%r8, %rbx
               	xorq	$-0x1, %rbx
               	movq	0x58(%rsp), %r8
               	cmpq	%r8, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	leaq	0x1(%r9), %r14
               	leaq	0x1(%rbx), %r9
               	movq	%r9, %rbx
               	subq	%r13, %rbx
               	movabsq	$-0x6db6db6db6db749a, %r11 # imm = 0x9249249249248B66
               	movq	%r14, %rcx
               	cmpq	%r11, %r14
               	jne	<addr>
               	movabsq	$-0x6db6db6dc, %r11     # imm = 0xFFFFFFF924924924
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	je	<addr>
               	movl	$0x7, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
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
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%ecx, %ecx
               	movl	$0x80, %ebx
               	movq	%rcx, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %r12
               	orq	%r12, %rcx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
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
               	subq	%r15, %rcx
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	0x58(%rsp), %r8
               	movq	%r12, %r9
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %rcx
               	cmpq	%r8, %r9
               	setb	%r8b
               	movzbq	%r8b, %r8
               	incq	%r9
               	incq	%rcx
               	subq	%r8, %rcx
               	cmpq	$-0x3, %r9
               	jne	<addr>
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x8, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movl	$0x3039, %r8d           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rbx
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%r8, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %r8
               	orq	%r8, %r9
               	cmpq	$0x40, %rbx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r8
               	xorq	$0x1, %r8
               	xorl	%r14d, %r14d
               	subq	%r8, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r8
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%r8, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r12, %r9
               	movl	$0xc0000000, %r11d      # imm = 0xC0000000
               	movq	%r8, %rcx
               	cmpq	%r11, %r8
               	jne	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rbx
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rbx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r9
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	$-0x1, %rcx
               	movq	%rbx, %r8
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%rcx
               	incq	%r8
               	subq	%r9, %r8
               	cmpq	$-0x3039, %rcx          # imm = 0xCFC7
               	jne	<addr>
               	cmpq	$-0x1, %r8
               	je	<addr>
               	movl	$0xa, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%r8d, %r8d
               	movl	$0x80, %r12d
               	movq	%r8, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r8
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%rbx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	cmpq	$0x40, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x40, %r8
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %r8
               	subq	%r15, %r8
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
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	jne	<addr>
               	cmpq	$-0x1, %r12
               	je	<addr>
               	movl	$0xb, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%r8d, %r8d
               	movl	$0x80, %r12d
               	movq	%r8, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r8
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%rbx, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	cmpq	$0x40, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x40, %r8
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r14d, %r14d
               	subq	%rbx, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %r8
               	subq	%r15, %r8
               	orq	%r13, %rbx
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%r9, %r8
               	cmpq	$0x3039, %rcx           # imm = 0x3039
               	jne	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xc, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r13
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rcx, %rbx
               	movq	%rdx, %r9
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%rcx
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rcx
               	movq	%r15, %rbx
               	orq	%r14, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	testq	%rcx, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
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
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	leaq	<rip>, %r8
               	movq	(%r8), %rcx
               	xorl	%ebx, %ebx
               	movq	%r9, %r10
               	imulq	%rcx, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%r9d, %r13d
               	movq	%r9, %r14
               	shrq	$0x20, %r14
               	movl	%ecx, %r15d
               	movq	%rcx, %r10
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
               	imulq	%r12, %rcx
               	addq	%r13, %r9
               	leaq	(%r9,%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	(%r8), %r13
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rcx, %r9
               	movq	%rdx, %rbx
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rcx
               	shrq	$0x3f, %r9
               	orq	%r9, %rcx
               	movq	%r15, %r9
               	orq	%r14, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	testq	%rcx, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rcx, %rcx
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
               	subq	0x58(%rsp), %rcx
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x48(%rsp), %r8
               	addq	%r8, %r9
               	cmpq	%r8, %r9
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %r10
               	movq	0x40(%rsp), %rcx
               	addq	%r10, %rcx
               	addq	%r8, %rcx
               	movq	%rdx, %r8
               	xorq	%r9, %r8
               	xorq	%rax, %rcx
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %r8d           # imm = 0x3039
               	movabsq	$0x3000000000, %r9      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rbx
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%r8, %r13
               	shlq	%r13
               	shlq	%r9
               	shrq	$0x3f, %r8
               	orq	%r8, %r9
               	cmpq	$0x40, %rbx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r8
               	xorq	$0x1, %r8
               	xorl	%r14d, %r14d
               	subq	%r8, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r8
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	testq	%r8, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r9, %r14
               	subq	%r12, %r14
               	movq	0x50(%rsp), %rcx
               	movq	%r8, %r10
               	imulq	%rcx, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	%r8d, %r9d
               	movq	%r8, %rbx
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
               	imulq	$-0x40, %r8, %r8
               	imulq	%r14, %rcx
               	addq	%r9, %r8
               	leaq	(%r8,%rcx), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%ebx, %ebx
               	movl	$0x80, %r12d
               	movq	%rbx, %rcx
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%rcx, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rbx
               	movq	%r14, %rcx
               	orq	%r13, %rcx
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rbx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%rcx, %rcx
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r14, %rbx
               	subq	%r15, %rbx
               	orq	%r13, %r9
               	decq	%r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	$-0x1, %rcx
               	movq	%rbx, %r8
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	leaq	0x1(%rcx), %rbx
               	leaq	0x1(%r8), %rcx
               	negq	%r9
               	addq	%rcx, %r9
               	movq	0x58(%rsp), %rcx
               	leaq	(%rcx,%rbx), %r8
               	cmpq	%rcx, %r8
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%r9, %r10
               	movq	0x50(%rsp), %r9
               	addq	%r10, %r9
               	addq	%r9, %rcx
               	xorq	$-0x3039, %r8           # imm = 0xCFC7
               	movabsq	$-0x3000000001, %r11    # imm = 0xFFFFFFCFFFFFFFFF
               	xorq	%r11, %rcx
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r12
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x80, %r9d
               	movq	%r8, %rbx
               	movq	%rdx, %rcx
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rax, %r13
               	shrq	$0x3f, %r13
               	movq	%rbx, %r14
               	shlq	%r14
               	movq	%r8, %rdx
               	shlq	%rdx
               	movq	%rbx, %r8
               	shrq	$0x3f, %r8
               	orq	%r8, %rdx
               	movq	%r14, %r8
               	orq	%r13, %r8
               	movq	%rcx, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rax
               	testq	%rdx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r12, %r8
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %rbx
               	orq	%rbx, %rcx
               	xorq	$0x1, %rcx
               	xorl	%ebx, %ebx
               	subq	%rcx, %rbx
               	andq	%r12, %rbx
               	cmpq	%rbx, %r8
               	setb	%r14b
               	movzbq	%r14b, %r14
               	negq	%rbx
               	addq	%r8, %rbx
               	movq	%rdx, %r8
               	subq	%r14, %r8
               	orq	%r13, %rcx
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%edx, %edx
               	movl	$0x80, %r8d
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rax, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rcx, %r12
               	shlq	%r12
               	shlq	%rdx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rdx
               	movq	%r12, %rcx
               	orq	%rbx, %rcx
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %r9
               	orq	%r9, %rax
               	cmpq	$0x1, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rdx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	xorl	%ebx, %ebx
               	subq	%r9, %rbx
               	movq	%rsi, %r12
               	andq	%rbx, %r12
               	andq	%rdi, %rbx
               	cmpq	%r12, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rcx
               	subq	%rbx, %rdx
               	subq	%r14, %rdx
               	orq	%r13, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
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
               	movabsq	$-0x5555555555555555, %rax # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, %r9
               	shrq	%r9
               	movq	%r9, %rax
               	imulq	%rsi, %rax
               	subq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %rax
               	imulq	%r12, %rax
               	movq	%rdx, %rbx
               	subq	%rax, %rbx
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rcx
               	imulq	%r13, %rcx
               	movq	%rdx, %r9
               	subq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movq	%rcx, %r12
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rcx
               	imulq	%r13, %rcx
               	movq	%rdx, %rbx
               	subq	%rcx, %rbx
               	xorl	%ecx, %ecx
               	movq	%rcx, %r12
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rcx # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %rbx
               	shrq	%rbx
               	movq	%rbx, %rcx
               	imulq	%rsi, %rcx
               	movq	%rdx, %r9
               	subq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movq	%rcx, %r12
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rcx # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %r9
               	shrq	%r9
               	movq	%r9, %rcx
               	imulq	%rsi, %rcx
               	movq	%rdx, %r12
               	subq	%rcx, %r12
               	xorl	%ecx, %ecx
               	movq	%rcx, %rbx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
