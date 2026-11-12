
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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rbx, %rcx
               	leaq	(%rcx,%rax), %rbx
               	cmpq	%rcx, %rbx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x28(%rsp)
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	movq	0x18(%rsp), %rcx
               	subq	%rax, %rcx
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
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
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	shlq	$0x24, %rax
               	leaq	-0x10(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x0, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movq	0x20(%rsp), %rcx
               	shrq	$0x4, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3c, %rdx
               	orq	%rdx, %rcx
               	sarq	$0x4, %rax
               	leaq	-0x10(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	0x20(%rsp), %rbx
               	jne	<addr>
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
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
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
