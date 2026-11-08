
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	leaq	0x3(%rcx), %rsi
               	movb	%al, (%rsi)
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	leaq	<rip>, %rdx
               	movzwq	(%rdx), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rdx), %r10
               	movb	%r10b, 0x2(%rcx)
               	movl	$0x9, %edx
               	movq	%rsi, %rdi
               	subq	%rcx, %rdi
               	cmpq	$0x9, %rdi
               	jb	<addr>
               	movq	%rsi, %rdi
               	movq	%rcx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	leaq	0x3(%rcx), %rsi
               	movb	%al, (%rsi)
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movzwq	0x8(%rdx), %r10
               	movw	%r10w, 0x8(%rcx)
               	movl	$0x7, %edx
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	cmpq	$0x7, %rdi
               	jb	<addr>
               	movq	%rcx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	leaq	<rip>, %rdx
               	movzwq	(%rdx), %r10
               	movw	%r10w, (%rcx)
               	leaq	0x2(%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movsbq	(%rsi,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x7, %eax
               	jge	<addr>
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x9, %eax
               	jge	<addr>
               	jmp	<addr>
