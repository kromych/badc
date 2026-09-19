
loop_idiom_overlap.x64:	file format elf64-x86-64

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

<copy_up>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x9, %rcx
               	jb	<addr>
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movsbq	(%rsi,%rax), %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x9, %eax
               	jge	<addr>
               	jmp	<addr>

<copy_down>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x7, %rcx
               	jb	<addr>
               	movl	$0x7, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movsbq	(%rsi,%rax), %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x7, %eax
               	jge	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%rbx), %rdi
               	movl	$0x9, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xa, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%rbx), %rsi
               	movl	$0x7, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	cmpl	$0xa, %eax
               	jge	<addr>
               	leaq	0x2(%rax), %rcx
               	movsbq	(%rbx,%rax), %rdx
               	movb	%dl, (%rbx,%rcx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
