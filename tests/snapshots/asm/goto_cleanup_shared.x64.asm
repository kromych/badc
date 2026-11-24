
goto_cleanup_shared.x64:	file format elf64-x86-64

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

<many>:
               	movq	%rdi, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rcx,%rdx)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rcx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x7c, (%rcx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	$0x0, (%rcx,%rsi)
               	retq
               	cmpl	$0x2, %eax
               	je	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	-0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	-0x4(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x2d, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x2e, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	xorl	%eax, %eax
               	retq

<nested>:
               	xorl	%ecx, %ecx
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x61, (%rdx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%cl, (%rdx,%rsi)
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x7c, (%rdx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%cl, (%rdx,%rsi)
               	addq	$0xa, %rax
               	retq
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x2, %edi
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x61, (%rdx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%cl, (%rdx,%rsi)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	cmpl	$0x4, %edi
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, <rip> # <addr>
               	movb	$0x2d, (%rdx,%rsi)
               	movslq	<rip>, %rsi # <addr>
               	movb	%cl, (%rdx,%rsi)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rdx,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rdx,%rcx)
               	retq

<lists>:
               	cmpl	$0x1, %edi
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x61, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x7c, (%rax,%rcx)
               	movslq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rax,%rcx)
               	retq
               	cmpl	$0x2, %edi
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x62, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movb	$0x2d, (%rax,%rcx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x62, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, <rip> # <addr>
               	movb	$0x61, (%rax,%rdx)
               	movslq	<rip>, %rdx # <addr>
               	movb	$0x0, (%rax,%rdx)
               	jmp	<addr>

<vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, %r9d
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movslq	<rip>, %r8 # <addr>
               	leaq	0x1(%r8), %r12
               	movl	%r12d, <rip> # <addr>
               	movb	$0x2e, (%rcx,%r8)
               	movslq	<rip>, %r8 # <addr>
               	movb	$0x0, (%rcx,%r8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rsp, %rbx
               	movq	%r9, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r8
               	subq	%r11, %r8
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r8, %rsp
               	movb	%al, (%r8)
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%r8, %rdi
               	nop
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movslq	<rip>, %r8 # <addr>
               	leaq	0x1(%r8), %r13
               	movl	%r13d, <rip> # <addr>
               	movb	$0x61, (%rcx,%r8)
               	movslq	<rip>, %r8 # <addr>
               	movb	$0x0, (%rcx,%r8)
               	movq	%rbx, %rsp
               	jmp	<addr>
               	cmpl	$0x1, %esi
               	je	<addr>
               	movslq	<rip>, %r8 # <addr>
               	leaq	0x1(%r8), %r13
               	movl	%r13d, <rip> # <addr>
               	movb	$0x2d, (%rcx,%r8)
               	movslq	<rip>, %r8 # <addr>
               	movb	$0x0, (%rcx,%r8)
               	movslq	<rip>, %r8 # <addr>
               	leaq	0x1(%r8), %r13
               	movl	%r13d, <rip> # <addr>
               	movb	$0x61, (%rcx,%r8)
               	movslq	<rip>, %r8 # <addr>
               	movb	$0x0, (%rcx,%r8)
               	movq	%rbx, %rsp
               	jmp	<addr>
               	movl	$0x1, %r12d
               	cmpq	%rdi, %r8
               	cmovneq	%r12, %rdx
               	jmp	<addr>
               	movq	%rdx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x4, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0xd, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	nop
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xe, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0xf, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	%edi, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	nopw	(%rax,%rax)
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rbx # <addr>
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rbx,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	movl	%esi, <rip> # <addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x10, %edi
               	callq	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	$0x10, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	movsbq	(%rsi,%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	retq
