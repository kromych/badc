
a_step_read_by_a_later_branch.x64:	file format elf64-x86-64

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

<separators>:
               	leaq	0x2(%rdi), %rcx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rcx, %rax
               	mulq	%rsi
               	shrq	%rdx
               	leaq	(%rdx,%rdx,2), %rax
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	subq	$0x1, %rdi
               	jb	<addr>
               	leaq	-0x1(%rcx), %rdx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	incq	%rax
               	movl	$0x2, %ecx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	subq	$0x1, %rdi
               	jae	<addr>
               	retq

<group>:
               	xorl	%ecx, %ecx
               	movsbq	(%rdi,%rcx), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	cmpl	$0x39, %eax
               	jg	<addr>
               	incq	%rcx
               	movsbq	(%rdi,%rcx), %rax
               	nopl	(%rax)
               	cmpl	$0x30, %eax
               	jge	<addr>
               	leaq	0x2(%rcx), %r8
               	movabsq	$-0x5555555555555555, %r9 # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r8, %rax
               	mulq	%r9
               	shrq	%rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%r8, %rax
               	subq	%rdx, %rax
               	subq	$0x1, %rcx
               	jb	<addr>
               	incq	%rsi
               	incq	%rdi
               	movsbq	-0x1(%rdi), %rdx
               	movb	%dl, -0x1(%rsi)
               	leaq	-0x1(%rax), %rdx
               	nop
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rsi
               	movb	$0x2c, -0x1(%rsi)
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rdx, %rax
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movq	%rdx, %rax
               	subq	$0x1, %rcx
               	jae	<addr>
               	incq	%rsi
               	incq	%rdi
               	movsbq	-0x1(%rdi), %rax
               	movb	%al, -0x1(%rsi)
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	retq

<main>:
               	subq	$0x28, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	nopl	(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
