
inline_asm_a64_x19_clobber_dynamic_frame.x64:	file format elf64-x86-64

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

<clobbered>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	movl	$0x20, %eax
               	movq	$0x5, -0x1020(%rbp)
               	movq	$0x7, -0x1018(%rbp)
               	movq	$0xb, -0x1010(%rbp)
               	movb	$0x1, -0x1000(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	movb	$0x3, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	movq	-0x1010(%rbp), %rsi
               	addq	%rsi, %rdx
               	addq	$0x2a, %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1020(%rbp)
               	movq	-0x1018(%rbp), %rax
               	movq	-0x1020(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1018(%rbp)
               	movq	-0x1010(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1010(%rbp)
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	-0x1010(%rbp), %rdx
               	addq	%rdx, %rax
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x1000(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq

<jumped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	movl	$0x20, %eax
               	movslq	%esi, %rsi
               	movq	$0x5, -0x1020(%rbp)
               	movq	$0x7, -0x1018(%rbp)
               	movq	$0xb, -0x1010(%rbp)
               	movb	$0x1, -0x1000(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	movb	$0x3, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	movq	-0x1010(%rbp), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1020(%rbp)
               	movq	-0x1018(%rbp), %rax
               	movq	-0x1020(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1018(%rbp)
               	movq	-0x1010(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1010(%rbp)
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	-0x1010(%rbp), %rdx
               	addq	%rdx, %rax
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x1000(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movq	-0x1020(%rbp), %rax
               	addq	$0x64, %rax
               	movq	%rax, -0x1020(%rbp)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x20, %edi
               	callq	<addr>
               	cmpq	$0xe0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x20, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x20, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x18e, %rax            # imm = 0x18E
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
