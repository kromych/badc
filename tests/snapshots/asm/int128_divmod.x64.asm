
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
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %rcx
               	orq	%rax, %rcx
               	orq	%rdx, %rax
               	movq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r13
               	xorl	%r8d, %r8d
               	movl	$0x80, %edi
               	movq	%r8, %r12
               	movq	%rsi, %rbx
               	movq	%rdx, %r9
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%r9, %r14
               	shrq	$0x3f, %r14
               	movq	%r12, %r15
               	shlq	%r15
               	shlq	%r8
               	shrq	$0x3f, %r12
               	orq	%r12, %r8
               	movq	%r15, %r12
               	orq	%r14, %r12
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	testq	%r8, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%r8, %r8
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
               	subq	$0x0, %r8
               	subq	0x58(%rsp), %r8
               	orq	%r15, %rbx
               	decq	%rdi
               	testq	%rdi, %rdi
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
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rbx
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rdx, %r12
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
               	shlq	%rdx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rdx
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
               	subq	$0x0, %rdi
               	subq	%r14, %rdi
               	orq	%r13, %rsi
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x7, %r9
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %edx
               	movl	$0x1, %esi
               	movq	%rax, %rdi
               	orq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	movq	%rcx, %r9
               	movq	%rax, %rbx
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rbx, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rbx
               	shrq	$0x3f, %r9
               	orq	%r9, %rbx
               	cmpq	$0x1, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %edi
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
               	movq	%rax, %rdi
               	orq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r13
               	shrq	$0x3f, %r13
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r14, %r9
               	orq	%r13, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	cmpq	$0x1, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rdi
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r9
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x4, %edi
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
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r8
               	xorl	%edi, %edi
               	xorl	%ebx, %ebx
               	movl	$0x80, %r9d
               	movq	%rbx, %r12
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rdi, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rbx
               	shrq	$0x3f, %r12
               	orq	%r12, %rbx
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r8, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %r8
               	orq	%r8, %rdi
               	cmpq	$0x1, %rbx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x1, %rbx
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
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rbx
               	subq	0x58(%rsp), %rbx
               	orq	%r15, %r8
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x5, %edi
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
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %rbx
               	xorl	%r9d, %r9d
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r9, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r9
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r9
               	cmpq	$0x1, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rdi
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	$0x3, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %rbx
               	xorq	$0x1, %rbx
               	xorl	%r13d, %r13d
               	subq	%rbx, %r13
               	movq	%rdx, %r14
               	andq	%r13, %r14
               	andq	%rsi, %r13
               	cmpq	%r14, %r12
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x58(%rsp)
               	subq	%r14, %r12
               	subq	%r13, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r8
               	cmpq	%r8, %r12
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x6, %edi
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
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
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
               	subq	$0x0, %rdi
               	subq	%r15, %rdi
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	incq	%r9
               	incq	%r8
               	negq	%rbx
               	addq	%r8, %rbx
               	movabsq	$-0x6db6db6db6db749a, %r11 # imm = 0x9249249249248B66
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$-0x6db6db6dc, %r11     # imm = 0xFFFFFFF924924924
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	je	<addr>
               	movl	$0x7, %edi
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
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r14
               	shlq	%r14
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
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
               	subq	$0x0, %rdi
               	subq	%r15, %rdi
               	orq	%r14, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	subq	%r9, %rdi
               	cmpq	$-0x3, %r8
               	jne	<addr>
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	movl	$0x8, %edi
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
               	xorl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorl	%ebx, %ebx
               	xorq	%rbx, %r9
               	xorq	%rbx, %r8
               	testq	%r9, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	leaq	(%r9), %r13
               	subq	$0x0, %r8
               	subq	%rbx, %r8
               	movl	$0xc0000000, %r11d      # imm = 0xC0000000
               	movq	%r13, %rdi
               	cmpq	%r11, %r13
               	jne	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x9, %edi
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
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	subq	%r9, %rdi
               	cmpq	$-0x3039, %r8           # imm = 0xCFC7
               	jne	<addr>
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	movl	$0xa, %edi
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
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorq	$-0x1, %r9
               	xorq	$-0x1, %r8
               	cmpq	$-0x1, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	leaq	0x1(%r9), %r13
               	incq	%r8
               	negq	%rbx
               	addq	%r8, %rbx
               	movabsq	$-0xc0000000, %r11      # imm = 0xFFFFFFFF40000000
               	movq	%r13, %rdi
               	cmpq	%r11, %r13
               	jne	<addr>
               	cmpq	$-0x1, %rbx
               	je	<addr>
               	movl	$0xb, %edi
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
               	xorl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	0x58(%rsp), %r8
               	movq	%r12, %r9
               	xorq	%r8, %r9
               	xorq	%r8, %rdi
               	testq	%r9, %r9
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	$0x0, %r9
               	subq	$0x0, %rdi
               	subq	%r8, %rdi
               	cmpq	$0x3039, %r9            # imm = 0x3039
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %edi
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
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r13
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %rbx
               	movq	%rcx, %r9
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %rbx
               	orq	%rbx, %rdi
               	movq	%r15, %rbx
               	orq	%r14, %rbx
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %r9
               	orq	%r9, %r12
               	testq	%rdi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
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
               	subq	$0x0, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x50(%rsp), %r8
               	movq	(%r8), %rdi
               	xorl	%ebx, %ebx
               	movq	%r9, %r10
               	imulq	%rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	%r9d, %r13d
               	movq	%r9, %r14
               	shrq	$0x20, %r14
               	movl	%edi, %r15d
               	movq	%rdi, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r13, %r10
               	imulq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	%r14, %r15
               	addq	0x38(%rsp), %r15
               	movl	%r15d, %r10d
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x20, %r15
               	imulq	0x58(%rsp), %r13
               	addq	0x38(%rsp), %r13
               	shrq	$0x20, %r13
               	imulq	0x58(%rsp), %r14
               	addq	%r15, %r14
               	addq	%r14, %r13
               	imulq	%rbx, %r9
               	imulq	%r12, %rdi
               	addq	%r13, %r9
               	leaq	(%r9,%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%r8), %r13
               	movq	%rax, %rdi
               	orq	%rbx, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%edi, %edi
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movq	%rax, %r12
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r12, %r14
               	shrq	$0x3f, %r14
               	movq	%r9, %r15
               	shlq	%r15
               	shlq	%rdi
               	shrq	$0x3f, %r9
               	orq	%r9, %rdi
               	movq	%r15, %r9
               	orq	%r14, %r9
               	movq	%rbx, %r15
               	shlq	%r15
               	shlq	%r12
               	shrq	$0x3f, %rbx
               	orq	%rbx, %r12
               	testq	%rdi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	testq	%rdi, %rdi
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
               	subq	$0x0, %rdi
               	subq	0x58(%rsp), %rdi
               	orq	%r15, %rbx
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	0x40(%rsp), %r8
               	addq	%r8, %r9
               	cmpq	%r8, %r9
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r10
               	movq	0x38(%rsp), %rdi
               	addq	%r10, %rdi
               	addq	%r8, %rdi
               	movq	%rcx, %r8
               	xorq	%r9, %r8
               	xorq	%rax, %rdi
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	xorl	%ebx, %ebx
               	xorq	%rbx, %r9
               	xorq	%r8, %rbx
               	testq	%r9, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	leaq	(%r9), %r8
               	leaq	(%rbx), %r9
               	movq	%r9, %r14
               	subq	%r13, %r14
               	movq	0x48(%rsp), %rdi
               	movq	%r8, %r10
               	imulq	%rdi, %r10
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
               	imulq	%r14, %rdi
               	addq	%r9, %r8
               	leaq	(%r8,%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x3039, %r9d           # imm = 0x3039
               	movabsq	$0x3000000000, %r8      # imm = 0x3000000000
               	xorl	%edi, %edi
               	movl	$0x80, %ebx
               	movq	%rdi, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r8, %r13
               	shrq	$0x3f, %r13
               	movq	%r12, %r14
               	shlq	%r14
               	shlq	%rdi
               	shrq	$0x3f, %r12
               	orq	%r12, %rdi
               	movq	%r14, %r12
               	orq	%r13, %r12
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %r9
               	orq	%r9, %r8
               	cmpq	$0x40, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x40, %rdi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	andq	%r15, %r14
               	orq	%r14, %r9
               	xorq	$0x1, %r9
               	xorl	%r14d, %r14d
               	subq	%r9, %r14
               	andq	$0x40, %r14
               	testq	%r12, %r12
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	$0x0, %r12
               	subq	%r14, %rdi
               	subq	%r15, %rdi
               	orq	%r13, %r9
               	decq	%rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %r8
               	xorq	$-0x1, %r8
               	xorq	$-0x1, %rdi
               	cmpq	$-0x1, %r8
               	setb	%r9b
               	movzbq	%r9b, %r9
               	incq	%r8
               	incq	%rdi
               	negq	%r9
               	addq	%rdi, %r9
               	movq	0x58(%rsp), %rdi
               	addq	%rdi, %r8
               	cmpq	%rdi, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%r9, %r10
               	movq	0x48(%rsp), %r9
               	addq	%r10, %r9
               	addq	%r9, %rdi
               	xorq	$-0x3039, %r8           # imm = 0xCFC7
               	movabsq	$-0x3000000001, %r11    # imm = 0xFFFFFFCFFFFFFFFF
               	xorq	%r11, %rdi
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rbx
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x80, %r9d
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rax, %r12
               	shrq	$0x3f, %r12
               	movq	%rcx, %r13
               	shlq	%r13
               	shlq	%r8
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r8
               	movq	%r13, %rcx
               	orq	%r12, %rcx
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	testq	%r8, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%r8, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rbx, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r12
               	orq	%r12, %rdi
               	xorq	$0x1, %rdi
               	xorl	%r12d, %r12d
               	subq	%rdi, %r12
               	andq	%rbx, %r12
               	cmpq	%r12, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rcx
               	subq	$0x0, %r8
               	subq	%r14, %r8
               	orq	%r13, %rdi
               	decq	%r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	%rax, %rcx
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x80, %r8d
               	movq	%rdi, %r9
               	movq	%rcx, %rdi
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rax, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rdi, %r12
               	shlq	%r12
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	movq	%r12, %rdi
               	orq	%rbx, %rdi
               	movq	%r9, %r13
               	shlq	%r13
               	shlq	%rax
               	shrq	$0x3f, %r9
               	orq	%r9, %rax
               	cmpq	$0x1, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %rcx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	xorl	%ebx, %ebx
               	subq	%r9, %rbx
               	movq	%rdx, %r12
               	andq	%rbx, %r12
               	andq	%rsi, %rbx
               	cmpq	%r12, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rdi
               	subq	%rbx, %rcx
               	subq	%r14, %rcx
               	orq	%r13, %r9
               	decq	%r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	jne	<addr>
               	testq	%rcx, %rcx
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
               	movq	%rdi, %rax
               	mulq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, %r9
               	shrq	%r9
               	movq	%r9, %rax
               	imulq	%rdx, %rax
               	subq	%rax, %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rax
               	imulq	%rbx, %rax
               	subq	%rax, %rcx
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	imulq	%r13, %rdi
               	movq	%rcx, %r9
               	subq	%rdi, %r9
               	xorl	%edi, %edi
               	movq	%rdi, %r12
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rdi
               	imulq	%r13, %rdi
               	movq	%rcx, %rbx
               	subq	%rdi, %rbx
               	xorl	%edi, %edi
               	movq	%rdi, %r12
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rbx, %rdi
               	imulq	%rdx, %rdi
               	movq	%rcx, %r9
               	subq	%rdi, %r9
               	xorl	%edi, %edi
               	movq	%rdi, %r12
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r9
               	shrq	%r9
               	movq	%r9, %rdi
               	imulq	%rdx, %rdi
               	movq	%rcx, %r12
               	subq	%rdi, %r12
               	xorl	%edi, %edi
               	movq	%rdi, %rbx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
