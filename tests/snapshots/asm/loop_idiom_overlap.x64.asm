
loop_idiom_overlap.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	leaq	0x3(%rcx), %rdx
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rcx)
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x9, %rsi
               	jb	<addr>
               	movq	%rdx, %rdi
               	movq	%rcx, %rsi
               	movl	$0x9, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	leaq	0x3(%rcx), %rdx
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movzwq	0x8(%rsi), %r10
               	movw	%r10w, 0x8(%rcx)
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x7, %rsi
               	jb	<addr>
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movw	$0x0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movw	$0x7978, <rip> # imm = 0x7978
                                                # <addr>
               	leaq	0x2(%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movsbq	(%rdx,%rax), %rsi
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x9, %eax
               	jl	<addr>
               	jmp	<addr>
