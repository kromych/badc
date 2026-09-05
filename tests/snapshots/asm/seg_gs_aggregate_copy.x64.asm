
seg_gs_aggregate_copy.x64:	file format elf64-x86-64

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

<ret_direct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	%gs:(%rcx), %rsi
               	movq	%rsi, (%rax)
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	0x10(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rdx, %rax
               	leave
               	retq

<asg_from_seg>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%gs:(%rcx), %rdx
               	movq	%rdx, (%rax)
               	leaq	0x8(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	0x10(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x10(%rax)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	xorq	%rax, %rax
               	retq

<asg_to_seg>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rdx, %gs:(%rcx)
               	movq	0x8(%rax), %rdx
               	leaq	0x8(%rcx), %rsi
               	movq	%rdx, %gs:(%rsi)
               	movq	0x10(%rax), %rdx
               	leaq	0x10(%rcx), %rsi
               	movq	%rdx, %gs:(%rsi)
               	movq	0x18(%rax), %rax
               	addq	$0x18, %rcx
               	movq	%rax, %gs:(%rcx)
               	xorq	%rax, %rax
               	retq

<asg_seg_seg>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%gs:(%rcx), %rdx
               	movq	%rdx, %gs:(%rax)
               	leaq	0x8(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	leaq	0x8(%rax), %rsi
               	movq	%rdx, %gs:(%rsi)
               	leaq	0x10(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	leaq	0x10(%rax), %rsi
               	movq	%rdx, %gs:(%rsi)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	addq	$0x18, %rax
               	movq	%rcx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<ret_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x30(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	%gs:(%rcx), %rsi
               	movq	%rsi, (%rax)
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	0x10(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rdx, %rax
               	leave
               	retq

<wr_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %gs:(%rdi)
               	movq	0x8(%rax), %rcx
               	leaq	0x8(%rdi), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	0x10(%rax), %rcx
               	leaq	0x10(%rdi), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	0x18(%rax), %rax
               	leaq	0x18(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	xorq	%rax, %rax
               	leave
               	retq

<cpy_seg_seg>:
               	movq	%gs:(%rsi), %rax
               	movq	%rax, %gs:(%rdi)
               	leaq	0x8(%rsi), %rax
               	movq	%gs:(%rax), %rax
               	leaq	0x8(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	leaq	0x10(%rsi), %rax
               	movq	%gs:(%rax), %rax
               	leaq	0x10(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	leaq	0x18(%rsi), %rax
               	movq	%gs:(%rax), %rax
               	leaq	0x18(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	xorq	%rax, %rax
               	retq

<init_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	-0x50(%rbp), %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%rcx), %rdx
               	movq	%rdx, (%rax)
               	leaq	0x8(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	0x10(%rcx), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x10(%rax)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	-0x60(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leave
               	retq

<sum_pt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x10(%rax), %edx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<pass_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %rax
               	leaq	-0x20(%rbp), %rdi
               	movq	%gs:(%rax), %rcx
               	movq	%rcx, (%rdi)
               	leaq	0x8(%rax), %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x8(%rdi)
               	leaq	0x10(%rax), %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x10(%rdi)
               	addq	$0x18, %rax
               	movq	%gs:(%rax), %rax
               	movq	%rax, 0x18(%rdi)
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leave
               	retq

<ret_nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x30(%rbp), %rcx
               	leaq	0x20(%rcx), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, (%rax)
               	leaq	0x28(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	0x30(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	addq	$0x38, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rdx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movabsq	$-0x112053135014111, %rcx # imm = 0xFEEDFACECAFEBEEF
               	movq	%rcx, (%rax)
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, 0x8(%rax)
               	movl	$0x55667788, %ecx       # imm = 0x55667788
               	movl	%ecx, 0x10(%rax)
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %gs:(%rcx)
               	movq	0x8(%rdx), %rdi
               	leaq	0x8(%rcx), %rsi
               	movq	%rdi, %gs:(%rsi)
               	movq	0x10(%rdx), %r8
               	leaq	0x10(%rcx), %rdi
               	movq	%r8, %gs:(%rdi)
               	movq	0x18(%rdx), %rdx
               	leaq	0x18(%rcx), %r9
               	movq	%rdx, %gs:(%r9)
               	leaq	<rip>, %rdx
               	movq	%gs:(%rdx), %rdx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%rdx, %r8
               	cmpq	%r11, %rdx
               	movl	$0x1, %edx
               	jne	<addr>
               	movl	%gs:(%rsi), %r8d
               	cmpl	$0x11223344, %r8d       # imm = 0x11223344
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movl	%gs:(%rdi), %edx
               	cmpl	$0x55667788, %edx       # imm = 0x55667788
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%gs:(%r9), %rdx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	%gs:(%rcx), %r8
               	movq	%r8, %gs:(%rdx)
               	movq	%gs:(%rsi), %rsi
               	leaq	0x8(%rdx), %r8
               	movq	%rsi, %gs:(%r8)
               	movq	%gs:(%rdi), %rsi
               	leaq	0x10(%rdx), %rdi
               	movq	%rsi, %gs:(%rdi)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	addq	$0x18, %rdx
               	movq	%rcx, %gs:(%rdx)
               	leaq	<rip>, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	movl	%gs:(%rdx), %edx
               	cmpl	$0x11223344, %edx       # imm = 0x11223344
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movl	%gs:(%rcx), %ecx
               	cmpl	$0x55667788, %ecx       # imm = 0x55667788
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	%gs:(%rdx), %rsi
               	movq	%rsi, (%rcx)
               	leaq	0x8(%rdx), %rdi
               	movq	%gs:(%rdi), %rdi
               	movq	%rdi, 0x8(%rcx)
               	leaq	0x10(%rdx), %rdi
               	movq	%gs:(%rdi), %rdi
               	movq	%rdi, 0x10(%rcx)
               	addq	$0x18, %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movl	0x8(%rcx), %edi
               	movl	0x10(%rcx), %r8d
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rcx, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	%edi, %esi
               	cmpl	$0x11223344, %esi       # imm = 0x11223344
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	%r8d, %esi
               	cmpl	$0x55667788, %esi       # imm = 0x55667788
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rdx
               	movq	%gs:(%rdx), %rsi
               	movq	%rsi, (%rax)
               	leaq	0x8(%rdx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	0x10(%rdx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	addq	$0x18, %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	(%rax), %rdx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movl	0x8(%rax), %edx
               	cmpl	$0x11223344, %edx       # imm = 0x11223344
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x10(%rax), %edx
               	cmpl	$0x55667788, %edx       # imm = 0x55667788
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rax), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %edx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rax, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%rsi, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%r11, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rax, -0xa0(%rbp)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rdi
               	movq	-0xa0(%rbp), %rsi
               	syscall
               	movq	-0xb8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xe0(%rbp), %rax
               	movq	-0xd8(%rbp), %rcx
               	movq	-0xd0(%rbp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	-0xc0(%rbp), %r11
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rbx, %rbx
               	movl	$0x20, %r12d
               	leaq	-0x40(%rbp), %rax
               	movabsq	$-0x112053135014111, %rcx # imm = 0xFEEDFACECAFEBEEF
               	movq	%rcx, (%rax)
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, 0x8(%rax)
               	movl	%ebx, 0xc(%rax)
               	movl	$0x55667788, %ecx       # imm = 0x55667788
               	movl	%ecx, 0x10(%rax)
               	movl	%ebx, 0x14(%rax)
               	leaq	-0x40(%rbp), %rsi
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, 0x18(%rsi)
               	subq	$0x20, %rsp
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%gs:(%rbx), %rax
               	movq	%rax, %gs:(%r12)
               	movl	$0x8, %ecx
               	movq	%gs:(%rcx), %rax
               	movl	$0x28, %edx
               	movq	%rax, %gs:(%rdx)
               	movl	$0x10, %edx
               	movq	%gs:(%rdx), %rax
               	movl	$0x30, %esi
               	movq	%rax, %gs:(%rsi)
               	movl	$0x18, %esi
               	movq	%gs:(%rsi), %rax
               	movl	$0x38, %edi
               	movq	%rax, %gs:(%rdi)
               	movl	$0x40, %eax
               	movabsq	$0x7777777777777777, %rdi # imm = 0x7777777777777777
               	movq	%rdi, %gs:(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%rbx), %r13
               	movq	%r13, (%rax)
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%gs:(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	%gs:(%rsi), %r14
               	movq	%r14, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	0x8(%rax), %r10d
               	movq	%r10, 0xb8(%rsp)
               	movl	0x10(%rax), %r10d
               	movq	%r10, 0xb0(%rsp)
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%r12), %rcx
               	movq	%rcx, (%rax)
               	movl	$0x28, %ecx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x30, %ecx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x38, %ecx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x88(%rsp)
               	movl	0x8(%rax), %ecx
               	movl	0x10(%rax), %edx
               	movq	0x18(%rax), %r10
               	movq	%r10, 0x80(%rsp)
               	movl	%ecx, %r10d
               	movq	%r10, 0xa8(%rsp)
               	movl	%edx, %r10d
               	movq	%r10, 0xa0(%rsp)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x20, %ecx
               	movq	%gs:(%rcx), %r12
               	movq	%r12, (%rax)
               	movl	$0x28, %ecx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x30, %ecx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x38, %ecx
               	movq	%gs:(%rcx), %r15
               	movq	%r15, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	0x8(%rax), %r10d
               	movq	%r10, 0x98(%rsp)
               	movl	0x10(%rax), %r10d
               	movq	%r10, 0x90(%rsp)
               	leaq	-0x40(%rbp), %rdi
               	movq	%gs:(%rbx), %rax
               	movq	%rax, (%rdi)
               	movl	$0x8, %eax
               	movq	%gs:(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x10, %eax
               	movq	%gs:(%rax), %rax
               	movq	%rax, 0x10(%rdi)
               	movl	$0x18, %eax
               	movq	%gs:(%rax), %rax
               	movq	%rax, 0x18(%rdi)
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %rdx
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9e, %ecx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rax, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%rsi, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%r11, -0xc0(%rbp)
               	movq	%rax, -0xb8(%rbp)
               	movq	%rcx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rbx, -0xa0(%rbp)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rdi
               	movq	-0xa0(%rbp), %rsi
               	syscall
               	movq	-0xb8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xe0(%rbp), %rax
               	movq	-0xd8(%rbp), %rcx
               	movq	-0xd0(%rbp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	-0xc0(%rbp), %r11
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%r13, %rcx
               	cmpq	%r11, %r13
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0xb8(%rsp), %rax
               	movl	%eax, %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	0xb0(%rsp), %rax
               	movl	%eax, %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%r14, %rax
               	cmpq	%r11, %r14
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movq	0x88(%rsp), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0xa8(%rsp), %rax
               	movl	%eax, %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	0xa0(%rsp), %rax
               	movl	%eax, %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x80(%rsp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%r12, %rcx
               	cmpq	%r11, %r12
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x98(%rsp), %rcx
               	movl	%ecx, %ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x90(%rsp), %rcx
               	movl	%ecx, %ecx
               	cmpl	$0x55667788, %ecx       # imm = 0x55667788
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%r15, %rax
               	cmpq	%r11, %r15
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movabsq	$0x114036bb3337aa, %r11 # imm = 0x114036BB3337AA
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x8(%rcx), %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x11223344, %edx       # imm = 0x11223344
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x10(%rcx), %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x55667788, %edx       # imm = 0x55667788
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	addq	$0x18, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rdx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	0x8(%rcx), %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x11223344, %edx       # imm = 0x11223344
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x10(%rcx), %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x55667788, %edx       # imm = 0x55667788
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x18(%rcx), %rax
               	movq	(%rax), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	(%rax), %rax
               	movabsq	$0x7777777777777777, %r11 # imm = 0x7777777777777777
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %r8
               	jmp	<addr>
