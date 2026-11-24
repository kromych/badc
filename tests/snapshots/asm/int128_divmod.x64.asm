
int128_divmod.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	<rip>, %r8 # <addr>
               	orq	%rsi, %r8
               	movq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	<rip>, %r9 # <addr>
               	cmpq	%r9, %rcx
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rdx, %rbx
               	imulq	%r9, %rbx
               	negq	%rbx
               	addq	%rcx, %rbx
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rbx, %rdx
               	divq	%r9
               	movq	%rax, %r9
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movabsq	$-0x3333333333333334, %r11 # imm = 0xCCCCCCCCCCCCCCCC
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	movq	-0x18(%rsp), %rax
               	movq	%rax, -0x18(%rsp)
               	movq	%rcx, %rdx
               	divq	%rsi
               	movq	%rax, %rcx
               	movq	-0x18(%rsp), %rax
               	imulq	%rsi, %rcx
               	subq	%rcx, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0x3, %ecx
               	movl	$0x1, %r9d
               	movq	%rdi, %rbx
               	orq	%r9, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rdi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rax
               	divq	%rsi
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%r8, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rdi, %rax
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
               	leaq	(%rsi,%rax), %rdx
               	movabsq	$-0x7766554433221103, %r11 # imm = 0x8899AABBCCDDEEFD
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rdi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%rsi
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	addq	%rsi, %rdx
               	cmpq	%rax, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rax
               	addq	%r8, %rax
               	negq	%rdx
               	addq	%rdi, %rdx
               	subq	%rsi, %rdx
               	cmpq	$0x1, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rdx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x18(%rsp), %rbx
               	orq	%rbx, %rsi
               	movq	%rsi, %rbx
               	xorq	$0x1, %rbx
               	movq	%rbx, %rsi
               	negq	%rsi
               	movq	%rcx, %rbx
               	andq	%rsi, %rbx
               	andq	%r9, %rsi
               	cmpq	%rbx, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	subq	%rbx, %rax
               	subq	%rsi, %rdx
               	subq	0x18(%rsp), %rdx
               	movabsq	$0x664421ffddbb9980, %r11 # imm = 0x664421FFDDBB9980
               	cmpq	%r11, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7fffffffffffffff, %rsi # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rax, %rbx
               	shrq	%rbx
               	movq	%rax, -0x18(%rsp)
               	movq	%rbx, %rax
               	divq	%rsi
               	movq	%rax, %rsi
               	movq	-0x18(%rsp), %rax
               	testq	%rsi, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rsi
               	movq	%rax, -0x18(%rsp)
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rdx, %rbx
               	movq	-0x18(%rsp), %rax
               	movq	%rsi, %rdx
               	imulq	%rcx, %rdx
               	addq	%rsi, %rbx
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
               	addq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	xorl	%edx, %edx
               	movq	%rsi, %rbx
               	shrq	%rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	movq	%rax, -0x18(%rsp)
               	mulq	%rcx
               	movq	%rdx, %rbx
               	movq	-0x18(%rsp), %rax
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	addq	%rbx, %rax
               	cmpq	%rdx, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rdx, %rsi
               	negq	%rax
               	subq	%rbx, %rax
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x3, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x18(%rsp), %rbx
               	orq	%rbx, %rdx
               	xorq	$0x1, %rdx
               	negq	%rdx
               	movq	%rcx, %rbx
               	andq	%rdx, %rbx
               	andq	%r9, %rdx
               	cmpq	%rbx, %rsi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	subq	%rbx, %rsi
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	subq	0x18(%rsp), %rdx
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rdx
               	imulq	%rsi, %rdx
               	negq	%rdx
               	addq	%rdi, %rdx
               	movq	%rax, -0x18(%rsp)
               	movq	%r8, %rax
               	divq	%rsi
               	movq	%rax, %rsi
               	movq	-0x18(%rsp), %rax
               	movq	<rip>, %rdx # <addr>
               	xorl	%r10d, %r10d
               	movq	%r10, 0x18(%rsp)
               	movq	%rsi, %rbx
               	imulq	%rdx, %rbx
               	movq	%rdx, %r10
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rsi, %rax
               	mulq	%r10
               	movq	%rdx, %r10
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%r10, 0x10(%rsp)
               	imulq	0x18(%rsp), %rsi
               	imulq	%rdx, %rax
               	movq	0x10(%rsp), %rdx
               	addq	%rsi, %rdx
               	leaq	(%rdx,%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %rsi # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%r8, %rax
               	divq	%rsi
               	imulq	%rsi, %rax
               	movq	%r8, %rdx
               	subq	%rax, %rdx
               	leaq	(%rbx,%rdx), %rax
               	cmpq	%rbx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	0x18(%rsp), %rdx
               	addq	%r10, %rdx
               	xorq	%r8, %rax
               	xorq	%rdi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%edx, %edx
               	cmpq	%rax, %rdi
               	jb	<addr>
               	movq	%rax, %r10
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rsi
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rsi, %rbx
               	imulq	%rax, %rbx
               	subq	%rbx, %rdi
               	movq	%rax, %r11
               	movq	%rdx, -0x20(%rsp)
               	movq	%rdi, %rdx
               	movq	%r8, %rax
               	divq	%r11
               	movq	%rax, %rdi
               	movq	-0x20(%rsp), %rdx
               	movq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r8
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rcx
               	movq	%r8, %rax
               	imulq	%rcx, %rax
               	addq	%r8, %rdx
               	cmpq	%rax, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%rax
               	addq	%rdi, %rax
               	subq	%rdx, %rsi
               	movq	%rsi, %rdx
               	subq	%r8, %rdx
               	cmpq	$0x1, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rdx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x3, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	orq	%rdi, %rsi
               	xorq	$0x1, %rsi
               	negq	%rsi
               	andq	%rsi, %rcx
               	andq	%r9, %rsi
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rcx, %rax
               	subq	%rsi, %rdx
               	subq	%rdi, %rdx
               	movabsq	$-0x4292c96669d3a3d8, %r11 # imm = 0xBD6D3699962C5C28
               	cmpq	%r11, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rdx, -0x20(%rsp)
               	movq	%rdi, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	movq	-0x20(%rsp), %rdx
               	movq	%rax, %r8
               	shrq	%r8
               	imulq	%r8, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rax, %r10
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdi
               	xorl	%esi, %esi
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	shrq	%rsi
               	movq	%rsi, %rdx
               	imulq	%rcx, %rdx
               	movq	%r8, %rax
               	subq	%rdx, %rax
               	xorl	%edx, %edx
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%rsi
               	shrq	%rdx
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rcx, %rbx
               	movq	%rsi, %rdx
               	jmp	<addr>
