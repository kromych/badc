
loop_idiom_transfer.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x10, %edx
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsbq	-0x30(%rbp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x303030303030303, %rax # imm = 0x303030303030303
               	movq	%rax, -0x40(%rbp)
               	movl	$0x3030303, -0x38(%rbp) # imm = 0x3030303
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movsbq	-0x34(%rbp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5050505, -0x3c(%rbp) # imm = 0x5050505
               	movl	$0x5050505, -0x38(%rbp) # imm = 0x5050505
               	movsbq	-0x3d(%rbp), %rcx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsbq	-0x34(%rbp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	xorl	%esi, %esi
               	movl	$0x28, %edx
               	movq	%rdi, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	(%rdi,%rax,4), %edx
               	movq	$-0x1, %rsi
               	cmpl	$0xa, %eax
               	cmovlq	%rcx, %rsi
               	cmpl	%esi, %edx
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
               	movl	$0x28, %edx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdi, (%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rsp), %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movsbq	(%rdi,%rax), %rdx
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x28, %eax
               	cmovgeq	%rcx, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x9, %edx
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
