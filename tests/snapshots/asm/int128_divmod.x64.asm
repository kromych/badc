
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	<rip>, %rcx # <addr>
               	xorl	%r8d, %r8d
               	movq	<rip>, %rsi # <addr>
               	orq	%r8, %rsi
               	movq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	<rip>, %r9 # <addr>
               	cmpq	%r9, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rbx
               	imulq	%r9, %rbx
               	negq	%rbx
               	addq	%rdi, %rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r8, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %r8 # <addr>
               	cmpq	%r8, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rax
               	pushq	%rax
               	movq	%rdi, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%r8, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0x1, %r9d
               	movq	%rcx, %rbx
               	orq	%r9, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movq	%rsi, %rax
               	shrq	%rax
               	movq	%rcx, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rax
               	divq	%r8
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%r8, %rdx
               	cmpq	%rax, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rsi, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	subq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	0x10(%rsp), %r10
               	cmpq	$0x3, %r10
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x18(%rsp), %rax
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	leaq	(%r8,%rax), %rdx
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rcx, %rdx
               	shrq	%rdx
               	movq	%rsi, %rax
               	shrq	%rax
               	movq	%rcx, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r8
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%rdx, %r8
               	cmpq	%rax, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	movq	%rcx, %rax
               	subq	%r8, %rax
               	subq	%rbx, %rax
               	cmpq	$0x1, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x18(%rsp), %rbx
               	orq	%rbx, %r8
               	movq	%r8, %rbx
               	xorq	$0x1, %rbx
               	movq	%rbx, %r8
               	negq	%r8
               	movq	%rdi, %rbx
               	andq	%r8, %rbx
               	andq	%r9, %r8
               	cmpq	%rbx, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	subq	%rbx, %rdx
               	subq	%r8, %rax
               	subq	0x18(%rsp), %rax
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	cmpq	%r11, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rax, %rbx
               	shrq	%rbx
               	pushq	%rax
               	movq	%rbx, %rax
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rax
               	testq	%r8, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %r8
               	pushq	%rax
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%rdx, %rbx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rdi, %rdx
               	addq	%r8, %rbx
               	cmpq	%rdx, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	negq	%rdx
               	addq	%rax, %rdx
               	movq	%rbx, %rax
               	negq	%rax
               	subq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x3, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rbx, %rax
               	xorq	$0x1, %rax
               	addq	%r8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %r8 # <addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%r8, %rbx
               	shrq	%rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	pushq	%rax
               	mulq	%rdi
               	movq	%rdx, %rbx
               	popq	%rax
               	movq	%rax, %rdx
               	imulq	%rdi, %rdx
               	addq	%rbx, %rax
               	cmpq	%rdx, %r8
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rdx, %r8
               	negq	%rax
               	subq	%rbx, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x18(%rsp), %rbx
               	orq	%rbx, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rdi, %rbx
               	andq	%rdx, %rbx
               	andq	%r9, %rdx
               	cmpq	%rbx, %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	subq	%rbx, %r8
               	subq	%rdx, %rax
               	subq	0x18(%rsp), %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %r8 # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	cmpq	%r8, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rdx
               	imulq	%r8, %rdx
               	negq	%rdx
               	addq	%rcx, %rdx
               	pushq	%rax
               	movq	%rsi, %rax
               	divq	%r8
               	movq	%rax, %r8
               	popq	%rax
               	movq	<rip>, %rdx # <addr>
               	xorl	%r10d, %r10d
               	movq	%r10, 0x18(%rsp)
               	movq	%r8, %rbx
               	imulq	%rdx, %rbx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	mulq	%r10
               	movq	%rdx, %r10
               	popq	%rdx
               	popq	%rax
               	movq	%r10, 0x10(%rsp)
               	imulq	0x18(%rsp), %r8
               	imulq	%rdx, %rax
               	movq	0x10(%rsp), %rdx
               	addq	%r8, %rdx
               	leaq	(%rdx,%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %r8 # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	%r8, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rsi, %rax
               	divq	%r8
               	imulq	%r8, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	leaq	(%rbx,%rdx), %rax
               	cmpq	%rbx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	0x18(%rsp), %rdx
               	addq	%r10, %rdx
               	xorq	%rsi, %rax
               	xorq	%rcx, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%edx, %edx
               	cmpq	%rax, %rcx
               	jb	<addr>
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rbx
               	imulq	%rax, %rbx
               	subq	%rbx, %rcx
               	movq	%rax, %r11
               	pushq	%rdx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%r11
               	movq	%rax, %rcx
               	popq	%rdx
               	movq	%r8, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%r8, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%r8, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%rsi
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	imulq	%rdi, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rax, %rcx
               	movq	%r8, %rax
               	subq	%rdx, %rax
               	subq	%rsi, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x3, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rdi, %rsi
               	andq	%rdx, %rsi
               	andq	%r9, %rdx
               	cmpq	%rsi, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rsi, %rcx
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
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
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, %rsi
               	shrq	%rsi
               	movq	%rsi, %rax
               	imulq	%rdi, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rdx, %r8
               	jmp	<addr>
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rcx
               	xorl	%r8d, %r8d
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r8 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %r8
               	shrq	%r8
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %r8 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%r8
               	shrq	%rdx
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rdi, %rbx
               	movq	%r8, %rdx
               	jmp	<addr>
