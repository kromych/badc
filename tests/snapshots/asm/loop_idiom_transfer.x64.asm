
loop_idiom_transfer.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	leaq	0x10(%rsp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	movl	$0x10, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsbq	0x20(%rsp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	movabsq	$0x303030303030303, %rax # imm = 0x303030303030303
               	movq	%rax, 0x10(%rsp)
               	movl	$0x3030303, 0x18(%rsp)  # imm = 0x3030303
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movsbq	0x1c(%rsp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	leaq	0x10(%rsp), %rcx
               	movl	$0x5050505, 0x14(%rsp)  # imm = 0x5050505
               	movl	$0x5050505, 0x18(%rsp)  # imm = 0x5050505
               	movsbq	0x13(%rsp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	addq	$0x4, %rcx
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsbq	0x1c(%rsp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	%rdx, %rdi
               	xorl	%esi, %esi
               	movl	$0x28, %edx
               	callq	<addr>
               	movq	0x8(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	(%rdx,%rax,4), %esi
               	movq	$-0x1, %rdi
               	cmpl	$0xa, %eax
               	cmovlq	%rcx, %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rax
               	leaq	0x1(%rax), %rdx
               	movb	%dl, (%rdi,%rax)
               	movb	%cl, (%rsi,%rax)
               	movq	%rdx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	%rdx, %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x28, %edx
               	callq	<addr>
               	movq	0x8(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movsbq	(%rdx,%rax), %rsi
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x28, %eax
               	cmovgeq	%rcx, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x1, %esi
               	movl	$0x9, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpb	$0x0, 0x19(%rsp)
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x58, %rsp
               	retq
