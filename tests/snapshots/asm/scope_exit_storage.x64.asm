
scope_exit_storage.x64:	file format elf64-x86-64

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

<fill>:
               	xorl	%eax, %eax
               	imulq	$0x1f, %rsi, %rcx
               	leaq	(%rcx,%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	%esi, 0x200(%rdi)
               	xorq	$-0x1, %rsi
               	movl	%esi, 0x204(%rdi)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<intact>:
               	xorl	%eax, %eax
               	imulq	$0x1f, %rsi, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	leaq	(%rcx,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	0x200(%rdi), %eax
               	cmpl	%esi, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	0x204(%rdi), %eax
               	xorq	$-0x1, %rsi
               	cmpl	%esi, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	xorl	%eax, %eax
               	retq

<release>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	0x200(%rdi), %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	popq	%rbp
               	retq

<crc_shape>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x228, %rsp            # imm = 0x228
               	pushq	%rbx
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testl	%eax, %eax
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movq	%rdi, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x8, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	testl	%eax, %eax
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	jmp	<addr>

<loop_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x420, %rsp            # imm = 0x420
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x64, %esi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x6, %ebx
               	jge	<addr>
               	leaq	-0x210(%rbp), %rdi
               	leaq	0x65(%rbx), %r12
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %ebx
               	je	<addr>
               	cmpl	$0x3, %ebx
               	jne	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x78, %esi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x78, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x64, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0xc, %edx
               	testl	%eax, %eax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<goto_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x430, %rsp            # imm = 0x430
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x438(%rsp)
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x82, %esi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jge	<addr>
               	leaq	-0x220(%rbp), %rdi
               	leaq	0x83(%rbx), %r12
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	0x438(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x8c, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x8c, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x82, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x17, %edx
               	testl	%eax, %eax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x85, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<switch_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x430, %rsp            # imm = 0x430
               	movq	%rdi, %rcx
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x96, %esi
               	movq	%rcx, 0x428(%rsp)
               	callq	<addr>
               	movq	0x428(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	jl	<addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x20, %edx
               	testl	%eax, %eax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x97, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x97, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq

<vla_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x800, %edx            # imm = 0x800
               	movl	$0x2000, %esi           # imm = 0x2000
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	%rsp, %rdi
               	movq	%rdx, %r11
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
               	movb	%cl, (%r8)
               	movsbq	%cl, %r8
               	movl	%r8d, <rip> # <addr>
               	testb	$0x1, %cl
               	je	<addr>
               	movq	%rdi, %rsp
               	jmp	<addr>
               	incq	%rax
               	movq	%rdi, %rsp
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rsp, %rdi
               	movq	%rdx, %r11
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
               	movb	%cl, 0x7ff(%r8)
               	movsbq	%cl, %r8
               	movl	%r8d, <rip> # <addr>
               	incq	%rax
               	movq	%rdi, %rsp
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	%rsp, %rdi
               	movq	%rdx, %r11
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
               	movb	%cl, (%r8)
               	movsbq	%cl, %r8
               	movl	%r8d, <rip> # <addr>
               	testb	$0x1, %cl
               	je	<addr>
               	movq	%rdi, %rsp
               	jmp	<addr>
               	incq	%rax
               	movq	%rdi, %rsp
               	jmp	<addr>
               	leave
               	retq

<touch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movsbq	%dil, %rcx
               	movb	%dil, -0x40(%rbp)
               	movsbq	-0x40(%rbp), %rax
               	subq	%rcx, %rax
               	leave
               	retq

<vla_entered_by_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x800, %r12d           # imm = 0x800
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	jmp	<addr>
               	leaq	0x2(%rax), %r13
               	movq	%rsp, %rcx
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movb	$0x5, (%rdx)
               	movl	$0x5, <rip> # <addr>
               	movq	%rcx, %rsp
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r13, %rax
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jge	<addr>
               	testl	%ebx, %ebx
               	je	<addr>
               	testb	$0x1, %bl
               	jne	<addr>
               	incq	%rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x800, %edi            # imm = 0x800
               	movl	$0x2000, %esi           # imm = 0x2000
               	callq	<addr>
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbp
               	retq
               	movl	$0x800, %edi            # imm = 0x800
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpl	$0x9c3, %eax            # imm = 0x9C3
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
