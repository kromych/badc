
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
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	(%r12,%rax), %rbx
               	cmpq	%r12, %rbx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpl	$0x1, %r12d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%r13, %rcx
               	subq	%rax, %rcx
               	cmpq	%rax, %r13
               	setb	%al
               	movzbq	%al, %rax
               	movq	%r14, %rdx
               	subq	%rax, %rdx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	shlq	$0x24, %rcx
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movq	%r13, %rcx
               	shrq	$0x4, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3c, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	%r13, %rbx
               	jne	<addr>
               	cmpq	%rax, %r12
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jae	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jae	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
