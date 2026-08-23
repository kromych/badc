
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
               	xorq	%rax, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x9, %rcx
               	jb	<addr>
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdi,%rcx), %rdx
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	movb	%r8b, (%rdx)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x9, %eax
               	jge	<addr>
               	jmp	<addr>

<copy_down>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x7, %rcx
               	jb	<addr>
               	movl	$0x7, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdi,%rcx), %rdx
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	movb	%r8b, (%rdx)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x7, %eax
               	jge	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rsi, %rsi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%rbx), %r12
               	movl	$0x9, %edx
               	movq	%r12, %rdi
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xa, %r13d
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	0x2(%rcx), %rdx
               	movslq	%edx, %rdx
               	addq	%rbx, %rdx
               	leaq	(%rbx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
