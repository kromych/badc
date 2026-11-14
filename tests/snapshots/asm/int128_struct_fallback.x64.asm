
int128_struct_fallback.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x1, %edi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	leaq	(%rcx,%rax), %r10
               	movq	%r10, 0x28(%rsp)
               	cmpq	%rcx, %r10
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x28(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	movq	0x10(%rsp), %rcx
               	subq	%rax, %rcx
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	$-0x1, %rax
               	incq	%rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	decq	%rcx
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%edi, %edi
               	shlq	$0x24, %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	sarq	$0x4, %rax
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	0x28(%rsp), %rcx
               	cmpq	0x18(%rsp), %rcx
               	jne	<addr>
               	movq	%rax, %r10
               	movq	0x20(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
               	jae	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
               	jae	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
