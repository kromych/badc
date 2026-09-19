
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
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%gs:(%rcx), %rdx
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	leaq	0x10(%rcx), %rdi
               	movq	%gs:(%rdi), %rdi
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
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
               	retq

<ret_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	%gs:(%rsi), %rcx
               	leaq	0x8(%rsi), %rdx
               	movq	%gs:(%rdx), %rdx
               	leaq	0x10(%rsi), %rdi
               	movq	%gs:(%rdi), %rdi
               	addq	$0x18, %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
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
               	retq

<init_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%gs:(%rsi), %rcx
               	leaq	0x8(%rsi), %rax
               	movq	%gs:(%rax), %rdx
               	leaq	0x10(%rsi), %rax
               	movq	%gs:(%rax), %rdi
               	leaq	0x18(%rsi), %rax
               	movq	%gs:(%rax), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	-0x40(%rbp), %rcx
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
               	leaq	-0x20(%rbp), %rax
               	movq	%gs:(%rdi), %rcx
               	movq	%rcx, (%rax)
               	leaq	0x8(%rdi), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	0x10(%rdi), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x10(%rax)
               	leaq	0x18(%rdi), %rdx
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movl	0x8(%rax), %esi
               	addq	%rsi, %rcx
               	movl	0x10(%rax), %esi
               	addq	%rsi, %rcx
               	leaq	(%rcx,%rdx), %rax
               	leave
               	retq

<ret_nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x20(%rsi), %rcx
               	movq	%gs:(%rcx), %rcx
               	leaq	0x28(%rsi), %rdx
               	movq	%gs:(%rdx), %rdx
               	leaq	0x30(%rsi), %rdi
               	movq	%gs:(%rdi), %rdi
               	addq	$0x38, %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movabsq	$-0x112053135014111, %rdx # imm = 0xFEEDFACECAFEBEEF
               	movq	%rdx, (%rax)
               	movl	$0x11223344, 0x8(%rax)  # imm = 0x11223344
               	movl	$0x55667788, 0x10(%rax) # imm = 0x55667788
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rsi, 0x18(%rax)
               	leaq	<rip>, %rcx
               	movq	%rdx, %gs:(%rcx)
               	movq	0x8(%rax), %rdi
               	leaq	0x8(%rcx), %rdx
               	movq	%rdi, %gs:(%rdx)
               	movq	0x10(%rax), %r8
               	leaq	0x10(%rcx), %rdi
               	movq	%r8, %gs:(%rdi)
               	leaq	0x18(%rcx), %rax
               	movq	%rsi, %gs:(%rax)
               	movq	%gs:(%rcx), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	%gs:(%rdx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	%gs:(%rdi), %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	0x18(%rcx), %rdx
               	movq	%gs:(%rdx), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	%gs:(%rcx), %rsi
               	movq	%rsi, %gs:(%rax)
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rdi
               	leaq	0x8(%rax), %rsi
               	movq	%rdi, %gs:(%rsi)
               	leaq	0x10(%rcx), %rdi
               	movq	%gs:(%rdi), %rdi
               	leaq	0x10(%rax), %r8
               	movq	%rdi, %gs:(%r8)
               	movq	%gs:(%rdx), %rcx
               	leaq	0x18(%rax), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	%gs:(%rax), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	%gs:(%rsi), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	0x10(%rcx), %rdx
               	movl	%gs:(%rdx), %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	leaq	0x18(%rcx), %rsi
               	movq	%gs:(%rsi), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%rcx), %rdi
               	movq	%rdi, (%rax)
               	leaq	0x8(%rcx), %r8
               	movq	%gs:(%r8), %r8
               	movq	%r8, 0x8(%rax)
               	movq	%gs:(%rdx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	%gs:(%rsi), %rdx
               	movq	%rdx, 0x18(%rax)
               	movl	0x8(%rax), %esi
               	movl	0x10(%rax), %eax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%ecx, %ecx
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpl	$0x11223344, %esi       # imm = 0x11223344
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rcx
               	movq	%gs:(%rcx), %rdx
               	movq	%rdx, (%rax)
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	0x10(%rcx), %rsi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x20, %esi
               	leaq	-0x40(%rbp), %rax
               	movabsq	$-0x112053135014111, %rdi # imm = 0xFEEDFACECAFEBEEF
               	movq	%rdi, (%rax)
               	movl	$0x11223344, 0x8(%rax)  # imm = 0x11223344
               	movl	%ecx, 0xc(%rax)
               	movl	$0x55667788, 0x10(%rax) # imm = 0x55667788
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x40(%rbp), %rdx
               	movabsq	$0x123456789abcdef, %r8 # imm = 0x123456789ABCDEF
               	movq	%r8, 0x18(%rdx)
               	leaq	-0x20(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	popq	%rcx
               	movq	%rdi, %gs:(%rcx)
               	movq	0x8(%rax), %rdx
               	movl	$0x8, %edi
               	movq	%rdx, %gs:(%rdi)
               	movq	0x10(%rax), %rdx
               	movl	$0x10, %r9d
               	movq	%rdx, %gs:(%r9)
               	movl	$0x18, %edx
               	movq	%r8, %gs:(%rdx)
               	movq	%gs:(%rcx), %rax
               	movq	%rax, %gs:(%rsi)
               	movq	%gs:(%rdi), %rax
               	movl	$0x28, %edi
               	movq	%rax, %gs:(%rdi)
               	movq	%gs:(%r9), %rax
               	movl	$0x30, %r8d
               	movq	%rax, %gs:(%r8)
               	movq	%gs:(%rdx), %rax
               	movl	$0x38, %r8d
               	movq	%rax, %gs:(%r8)
               	movl	$0x40, %eax
               	movabsq	$0x7777777777777777, %r8 # imm = 0x7777777777777777
               	movq	%r8, %gs:(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%rcx), %r9
               	movq	%r9, (%rax)
               	movl	$0x8, %r8d
               	movq	%gs:(%r8), %r8
               	movq	%r8, 0x8(%rax)
               	movl	$0x10, %r8d
               	movq	%gs:(%r8), %r8
               	movq	%r8, 0x10(%rax)
               	movq	%gs:(%rdx), %rbx
               	movq	%rbx, 0x18(%rax)
               	movl	0x8(%rax), %r12d
               	movl	0x10(%rax), %r13d
               	movq	%gs:(%rsi), %rdx
               	movq	%gs:(%rdi), %rsi
               	movl	$0x30, %eax
               	movq	%gs:(%rax), %rdi
               	movl	$0x38, %eax
               	movq	%gs:(%rax), %r8
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	0x8(%rax), %edx
               	movl	0x10(%rax), %r8d
               	movq	0x18(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x20, %esi
               	movq	%gs:(%rsi), %r14
               	movq	%r14, (%rax)
               	movl	$0x28, %esi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	movl	$0x30, %esi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	movl	$0x38, %esi
               	movq	%gs:(%rsi), %r15
               	movq	%r15, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	0x8(%rax), %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	0x10(%rax), %r10d
               	movq	%r10, 0x50(%rsp)
               	leaq	-0x40(%rbp), %rax
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %esi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x8(%rax)
               	movl	$0x10, %esi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x10(%rax)
               	movl	$0x18, %esi
               	movq	%gs:(%rsi), %rsi
               	movq	%rsi, 0x18(%rax)
               	movl	0x8(%rax), %edi
               	addq	%rdi, %rcx
               	movl	0x10(%rax), %edi
               	addq	%rdi, %rcx
               	leaq	(%rcx,%rsi), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%r9, %rcx
               	cmpq	%r11, %r9
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x11223344, %r12d      # imm = 0x11223344
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x55667788, %r13d      # imm = 0x55667788
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x48(%rsp), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x11223344, %edx       # imm = 0x11223344
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x55667788, %r8d       # imm = 0x55667788
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x40(%rsp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%r14, %rcx
               	cmpq	%r11, %r14
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x58(%rsp), %rcx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x50(%rsp), %rcx
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x38(%rsp), %rax
               	movabsq	$0x114036bb3337aa, %r11 # imm = 0x114036BB3337AA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
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
               	leaq	0x18(%rcx), %rdx
               	movq	(%rdx), %rdx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x20(%rcx), %rdx
               	movq	(%rdx), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leaq	0x8(%rdx), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x10(%rdx), %rax
               	movl	(%rax), %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x18(%rdx), %rax
               	movq	(%rax), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	(%rax), %rax
               	movabsq	$0x7777777777777777, %r11 # imm = 0x7777777777777777
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
