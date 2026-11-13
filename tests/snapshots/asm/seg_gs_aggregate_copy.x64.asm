
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
               	leaq	<rip>, %rcx # <addr>
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
               	leaq	<rip>, %rax # <addr>
               	movq	%gs:(%rax), %rcx
               	movq	%rcx, <rip> # <addr>
               	leaq	0x8(%rax), %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, <rip> # <addr>
               	leaq	0x10(%rax), %rcx
               	movq	%gs:(%rcx), %rcx
               	movq	%rcx, <rip> # <addr>
               	addq	$0x18, %rax
               	movq	%gs:(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	retq

<asg_to_seg>:
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rcx # <addr>
               	leaq	0x8(%rax), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	<rip>, %rcx # <addr>
               	leaq	0x10(%rax), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	<rip>, %rcx # <addr>
               	addq	$0x18, %rax
               	movq	%rcx, %gs:(%rax)
               	retq

<asg_seg_seg>:
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
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
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %gs:(%rdi)
               	movq	-0x18(%rbp), %rax
               	leaq	0x8(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	movq	-0x10(%rbp), %rax
               	leaq	0x10(%rdi), %rcx
               	movq	%rax, %gs:(%rcx)
               	movq	-0x8(%rbp), %rax
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
               	movq	%gs:(%rsi), %rax
               	leaq	0x8(%rsi), %rcx
               	movq	%gs:(%rcx), %rcx
               	leaq	0x10(%rsi), %rdx
               	movq	%gs:(%rdx), %rdx
               	addq	$0x18, %rsi
               	movq	%gs:(%rsi), %rsi
               	leaq	-0x20(%rbp), %rdi
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x40(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movq	-0x20(%rbp), %rax
               	movl	-0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<pass_ptr>:
               	movq	%gs:(%rdi), %rax
               	leaq	0x8(%rdi), %rcx
               	movq	%gs:(%rcx), %rcx
               	leaq	0x10(%rdi), %rdx
               	movq	%gs:(%rdx), %rdx
               	leaq	0x18(%rdi), %rsi
               	movq	%gs:(%rsi), %rsi
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
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
               	subq	$0x50, %rsp
               	movabsq	$-0x112053135014111, %rcx # imm = 0xFEEDFACECAFEBEEF
               	movq	%rcx, <rip> # <addr>
               	movl	$0x11223344, <rip> # imm = 0x11223344
                                                # <addr>
               	movl	$0x55667788, <rip> # imm = 0x55667788
                                                # <addr>
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rsi # <addr>
               	leaq	0x8(%rax), %rcx
               	movq	%rsi, %gs:(%rcx)
               	movq	<rip>, %rdi # <addr>
               	leaq	0x10(%rax), %rsi
               	movq	%rdi, %gs:(%rsi)
               	leaq	0x18(%rax), %rdi
               	movq	%rdx, %gs:(%rdi)
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	%gs:(%rcx), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	%gs:(%rsi), %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x18(%rcx), %rdx
               	movq	%gs:(%rdx), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	%gs:(%rcx), %rsi
               	movq	%rsi, %gs:(%rax)
               	leaq	0x8(%rcx), %rsi
               	movq	%gs:(%rsi), %rdi
               	leaq	0x8(%rax), %rsi
               	movq	%rdi, %gs:(%rsi)
               	addq	$0x10, %rcx
               	movq	%gs:(%rcx), %rcx
               	leaq	0x10(%rax), %rdi
               	movq	%rcx, %gs:(%rdi)
               	movq	%gs:(%rdx), %rcx
               	leaq	0x18(%rax), %rdx
               	movq	%rcx, %gs:(%rdx)
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	%gs:(%rsi), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdx
               	movl	%gs:(%rdx), %ecx
               	cmpl	$0x55667788, %ecx       # imm = 0x55667788
               	jne	<addr>
               	leaq	0x18(%rax), %rsi
               	movq	%gs:(%rsi), %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%gs:(%rax), %rcx
               	leaq	0x8(%rax), %rdi
               	movq	%gs:(%rdi), %r8
               	movq	%gs:(%rdx), %r9
               	movq	%gs:(%rsi), %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	cmpl	$0x11223344, %r8d       # imm = 0x11223344
               	jne	<addr>
               	cmpl	$0x55667788, %r9d       # imm = 0x55667788
               	jne	<addr>
               	movq	0x48(%rsp), %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	$0x0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	%gs:(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	%gs:(%rdi), %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%gs:(%rdx), %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%gs:(%rsi), %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi # <addr>
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x20, %edx
               	movabsq	$-0x112053135014111, %rcx # imm = 0xFEEDFACECAFEBEEF
               	movabsq	$0x123456789abcdef, %r8 # imm = 0x123456789ABCDEF
               	movq	%rcx, %gs:(%rax)
               	movl	$0x8, %ecx
               	movq	$0x11223344, %gs:(%rcx) # imm = 0x11223344
               	movl	$0x10, %esi
               	movq	$0x55667788, %gs:(%rsi) # imm = 0x55667788
               	movl	$0x18, %edi
               	movq	%r8, %gs:(%rdi)
               	movq	%gs:(%rax), %r8
               	movq	%r8, %gs:(%rdx)
               	movq	%gs:(%rcx), %r9
               	movl	$0x28, %r8d
               	movq	%r9, %gs:(%r8)
               	movq	%gs:(%rsi), %rsi
               	movl	$0x30, %r9d
               	movq	%rsi, %gs:(%r9)
               	movq	%gs:(%rdi), %rsi
               	movl	$0x38, %edi
               	movq	%rsi, %gs:(%rdi)
               	movl	$0x40, %esi
               	movabsq	$0x7777777777777777, %rdi # imm = 0x7777777777777777
               	movq	%rdi, %gs:(%rsi)
               	movq	%gs:(%rax), %r9
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x10, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x18, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%gs:(%rdx), %rdx
               	movq	%gs:(%r8), %r8
               	movl	$0x30, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x38, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x20, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0x28, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	$0x30, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	$0x38, %ecx
               	movq	%gs:(%rcx), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%gs:(%rax), %rax
               	movl	$0x8, %ecx
               	movq	%gs:(%rcx), %rcx
               	movl	$0x10, %esi
               	movq	%gs:(%rsi), %rsi
               	movl	$0x18, %edi
               	movq	%gs:(%rdi), %rdi
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%esi, %ecx
               	addq	%rcx, %rax
               	leaq	(%rax,%rdi), %r10
               	movq	%r10, (%rsp)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	cmpl	$0x11223344, %r8d       # imm = 0x11223344
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	0x20(%rsp), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	0x8(%rsp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	(%rsp), %rax
               	movabsq	$0x114036bb3337aa, %r11 # imm = 0x114036BB3337AA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x7777777777777777, %r11 # imm = 0x7777777777777777
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
