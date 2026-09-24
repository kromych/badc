
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
               	addq	%rax, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	%esi, 0x200(%rdi)
               	movq	%rsi, %rax
               	xorq	$-0x1, %rax
               	movl	%eax, 0x204(%rdi)
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	retq

<intact>:
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rcx
               	imulq	$0x1f, %rsi, %rdx
               	addq	%rax, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
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
               	movq	%rsi, %rcx
               	xorq	$-0x1, %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	xorl	%eax, %eax
               	retq

<release>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpq	$0x0, (%rdi)
               	je	<addr>
               	movq	(%rdi), %rdi
               	movl	0x200(%rdi), %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	popq	%rbp
               	retq

<crc_shape>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x438, %rsp            # imm = 0x438
               	pushq	%rbx
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	leaq	-0x430(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	leaq	-0x220(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	leaq	-0x430(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	leaq	-0x430(%rbp), %rdi
               	movq	%rdi, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x8, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %ebx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	jmp	<addr>

<goto_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x428, %rsp            # imm = 0x428
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %r13
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x82, %esi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jge	<addr>
               	leaq	-0x210(%rbp), %rdi
               	leaq	0x83(%rbx), %r12
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	testq	%r13, %r13
               	je	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x8c, %esi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x8c, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x82, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x17, %eax
               	jmp	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x85, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<vla_exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x800, %edx            # imm = 0x800
               	movl	$0x2000, %esi           # imm = 0x2000
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8
               	movq	%rcx, %rax
               	movq	%rsp, %rdi
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r9
               	subq	%r11, %r9
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r9, %rsp
               	movb	%cl, (%r9)
               	movsbq	%cl, %r9
               	movl	%r9d, (%r8)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	%rdi, %rsp
               	jmp	<addr>
               	incq	%rax
               	movq	%rdi, %rsp
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi
               	movq	%rsp, %r8
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r9
               	subq	%r11, %r9
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r9, %rsp
               	movb	%cl, 0x7ff(%r9)
               	movsbq	%cl, %r9
               	movl	%r9d, (%rdi)
               	incq	%rax
               	movq	%r8, %rsp
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8
               	movq	%rsp, %rdi
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r9
               	subq	%r11, %r9
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r9, %rsp
               	movb	%cl, (%r9)
               	movsbq	%cl, %r9
               	movl	%r9d, (%r8)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	%rdi, %rsp
               	jmp	<addr>
               	incq	%rax
               	movq	%rdi, %rsp
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<touch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	movsbq	%dil, %rcx
               	movb	%dil, (%rax)
               	movsbq	(%rax), %rax
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
               	testl	%ebx, %ebx
               	je	<addr>
               	testb	$0x1, %bl
               	jne	<addr>
               	incq	%rax
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
               	leaq	<rip>, %rdx
               	movl	$0x5, (%rdx)
               	movq	%rcx, %rsp
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r13, %rax
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jl	<addr>
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc60, %rsp            # imm = 0xC60
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
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
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdi
               	movl	$0x64, %esi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0xa50(%rbp), %rdi
               	leaq	0x65(%rbx), %r12
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0xa50(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %ebx
               	je	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	leaq	-0x840(%rbp), %rdi
               	movl	$0x78, %esi
               	callq	<addr>
               	leaq	-0x840(%rbp), %rdi
               	movl	$0x78, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x97, %esi
               	callq	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x97, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1f, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x800, %edi            # imm = 0x800
               	movl	$0x2000, %esi           # imm = 0x2000
               	callq	<addr>
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x800, %edi            # imm = 0x800
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpl	$0x9c3, %eax            # imm = 0x9C3
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x20, %eax
               	jmp	<addr>
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x98, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	leaq	-0x630(%rbp), %rdi
               	movl	$0x96, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	leaq	-0xc60(%rbp), %rdi
               	movl	$0x64, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
