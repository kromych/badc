
callee_function_types.x64:	file format elf64-x86-64

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

<twice>:
               	vmulsd	<rip>, %xmm0, %xmm0
               	retq

<half>:
               	vdivsd	<rip>, %xmm0, %xmm0
               	retq

<getfp>:
               	leaq	-<rip>, %rax # <addr>
               	retq

<getfp_t>:
               	leaq	-<rip>, %rax # <addr>
               	retq

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	-0xd0(%rbp), %edx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movl	-0xd0(%rbp), %edx
               	nopl	(%rax)
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x4, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x8, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x20, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x40, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x80, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x100, %rax            # imm = 0x100
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x200, %rax            # imm = 0x200
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x400, %rax            # imm = 0x400
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	ucomisd	<rip>, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movl	$0x8, %ebx
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x10, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movl	$0x3, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rcx
               	orq	$0x1000, %rcx           # imm = 0x1000
               	cmpq	$0x6, %rax
               	cmoveq	%rbx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	leaq	-<rip>, %rax # <addr>
               	decq	%rax
               	incq	%rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movl	$0x80, %ebx
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	leaq	-<rip>, %rax # <addr>
               	decq	%rax
               	incq	%rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x100, %rax            # imm = 0x100
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	0x18(%rsp), %rax
               	decq	%rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movq	%rbx, %rax
               	orq	$0x200, %rax            # imm = 0x200
               	ucomisd	<rip>, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x2, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x4, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x8, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movq	%rbx, %rax
               	orq	$0x10, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movq	%rbx, %rax
               	orq	$0x20, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x40, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x80, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
