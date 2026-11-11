
callee_function_types.x64:	file format elf64-x86-64

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

<twice>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	retq

<half>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
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
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rdx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rcx, %rdx
               	orq	$0x2, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x4, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rcx, %rdx
               	orq	$0x10, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rbx, %rcx
               	orq	$0x20, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x40, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x80, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rbx, %rcx
               	orq	$0x100, %rcx            # imm = 0x100
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x200, %rcx            # imm = 0x200
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x400, %rcx            # imm = 0x400
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rcx, %rdx
               	orq	$0x800, %rdx            # imm = 0x800
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x1000, %rdx           # imm = 0x1000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x2000, %rcx           # imm = 0x2000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rdx, -0x8(%rbp)
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rcx, %rsi
               	orq	$0x4000, %rsi           # imm = 0x4000
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x2, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rax, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x10, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rcx, %rdx
               	orq	$0x20, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x40, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rdx, %rsi
               	orq	$0x80, %rsi
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rdx, %rax
               	cmovneq	%rsi, %rax
               	cmovpq	%rsi, %rax
               	movq	%rax, %rdx
               	orq	$0x100, %rdx            # imm = 0x100
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	movq	%rax, %rdx
               	orq	$0x200, %rdx            # imm = 0x200
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rax, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rdx, %rsi
               	orq	$0x400, %rsi            # imm = 0x400
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	movq	%rcx, %rdx
               	orq	$0x800, %rdx            # imm = 0x800
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	movl	$0x3, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movq	%rdi, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rcx
               	orq	$0x1000, %rcx           # imm = 0x1000
               	cmpq	$0x6, %rax
               	movq	%rbx, %rax
               	cmovneq	%rcx, %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rax, %rdx
               	orq	$0x2000, %rdx           # imm = 0x2000
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rax, %rcx
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rcx, %rdx
               	orq	$0x4000, %rdx           # imm = 0x4000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x8000, %rdx           # imm = 0x8000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x10000, %rdx          # imm = 0x10000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rcx, %rdx
               	orq	$0x20000, %rdx          # imm = 0x20000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-<rip>, %rsi # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x2, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rcx, %rdx
               	orq	$0x4, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rcx
               	cmovpq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	$0x8, %rdx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rdx, %rdi
               	orq	$0x10, %rdi
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	cmovpq	%rdi, %rax
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rax, %rbx
               	cmovneq	%rdx, %rbx
               	cmovpq	%rdx, %rbx
               	leaq	-0x1(%rsi), %rax
               	incq	%rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x80, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	leaq	-<rip>, %rax # <addr>
               	decq	%rax
               	incq	%rax
               	leaq	0x1(%rax), %r12
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x100, %rcx            # imm = 0x100
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	leaq	-0x1(%r12), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x200, %rcx            # imm = 0x200
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %rax
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x2, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x4, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rbx, %rcx
               	orq	$0x10, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rbx, %rcx
               	orq	$0x20, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x40, %rbx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x80, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
