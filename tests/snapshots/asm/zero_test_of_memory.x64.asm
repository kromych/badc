
zero_test_of_memory.x64:	file format elf64-x86-64

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

<set8>:
               	cmpb	$0x0, 0x1(%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<clear8>:
               	cmpb	$0x0, 0x1(%rdi)
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<set16>:
               	cmpw	$0x0, 0x6(%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<clear16>:
               	cmpw	$0x0, 0x6(%rdi)
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<set32>:
               	cmpl	$0x0, 0x10(%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<clear32>:
               	cmpl	$0x0, 0x10(%rdi)
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<set64>:
               	cmpq	$0x0, 0x28(%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<clear64>:
               	cmpq	$0x0, 0x28(%rdi)
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<setu8>:
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<setu16>:
               	cmpw	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<setu32>:
               	cmpl	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<set_at16>:
               	cmpw	$0x0, (%rdi,%rsi,2)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<set_at64>:
               	movslq	%esi, %rsi
               	cmpq	$0x0, (%rdi,%rsi,8)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<fill>:
               	movq	%rsi, (%rdi)
               	retq

<set_local>:
               	subq	$0x18, %rsp
               	movq	%rdi, %rsi
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x0, 0x8(%rsp)
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq

<read_then_clear>:
               	movsbq	(%rdi), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rsi)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	retq

<length>:
               	movq	%rdi, %rax
               	movq	%rax, %rdi
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	incq	%rdi
               	cmpb	$0x0, (%rdi)
               	jne	<addr>
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	subq	$0x88, %rsp
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x30(%rdi)
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x48(%rsp), %rdi
               	movb	$-0x80, 0x49(%rsp)
               	movw	$0x8000, 0x4e(%rsp)     # imm = 0x8000
               	movl	$0x80000000, 0x58(%rsp) # imm = 0x80000000
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0x70(%rsp)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x48(%rsp), %rdi
               	movw	$0x100, 0x4e(%rsp)      # imm = 0x100
               	movl	$0x10000, 0x58(%rsp)    # imm = 0x10000
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x70(%rsp)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rdi)
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x1(%rax), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x8(%rsp), %rax
               	leaq	0x2(%rax), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x10(%rsp), %rax
               	leaq	0x4(%rax), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	0x28(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x18(%rsp), %rax
               	leaq	0x6(%rax), %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x28(%rsp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movabsq	$0x100000000, %rdi      # imm = 0x100000000
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x88, %rsp
               	retq
               	movb	$0x5, 0x20(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpb	$0x0, 0x20(%rsp)
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
