
param_entry_conversion.x64:	file format elf64-x86-64

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

<pass>:
               	movq	%rdi, %rax
               	retq

<across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movsbq	%dil, %rbx
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movslq	%edx, %r13
               	movswq	%si, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	0x30(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x30(%rsp), %rax
               	addq	%r10, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	movq	%r14, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	addq	%r15, %rax
               	movq	0x38(%rsp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<leaf>:
               	movsbq	%dil, %rdi
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	movswq	%si, %rsi
               	movabsq	$0xe8d4a51000, %rax     # imm = 0xE8D4A51000
               	imulq	%rdi, %rax
               	imulq	$0xf4240, %rsi, %rsi    # imm = 0xF4240
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	retq

<order>:
               	imulq	$0x2710, %rdi, %rax     # imm = 0x2710
               	imulq	$0x64, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	retq

<permute>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movsbq	%dl, %r13
               	movswq	%si, %r12
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	negq	%rax
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<low>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	incq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x5a5a5a5a5a5a5afb, %rdi # imm = 0x5A5A5A5A5A5A5AFB
               	movabsq	$-0x5a5a5a5a5a5a012c, %rsi # imm = 0xA5A5A5A5A5A5FED4
               	movabsq	$0x5a5a5a5afffffff0, %rdx # imm = 0x5A5A5A5AFFFFFFF0
               	movabsq	$-0x5a5a5a5a5a5a5a38, %rcx # imm = 0xA5A5A5A5A5A5A5C8
               	movq	$-0x3e8, %r8            # imm = 0xFC18
               	movabsq	$0x5a5a5a5a5a5aff00, %r9 # imm = 0x5A5A5A5A5A5AFF00
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	cmpq	$0xf81d, %rax           # imm = 0xF81D
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a9c, %rdi # imm = 0xA5A5A5A5A5A5A564
               	movabsq	$0x5a5a5a5a5a5afffe, %rsi # imm = 0x5A5A5A5A5A5AFFFE
               	movabsq	$-0x5a5a5a5af8a432eb, %rdx # imm = 0xA5A5A5A5075BCD15
               	movabsq	$0x5a5a5a5afffffff9, %rcx # imm = 0x5A5A5A5AFFFFFFF9
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	movabsq	$0x5af3266f22b8, %r11   # imm = 0x5AF3266F22B8
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a00009c40, %rdi # imm = 0xA5A5A5A5FFFF63C0
               	movabsq	$0x5a5a5a5a5a5a04d2, %rsi # imm = 0x5A5A5A5A5A5A04D2
               	movabsq	$-0x5a5a5a5a5a5a5a80, %rdx # imm = 0xA5A5A5A5A5A5A580
               	movq	-0x10(%rbp), %rax
               	callq	*%rax
               	cmpq	$-0x10c090e, %rax       # imm = 0xFEF3F6F2
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0x5a5a5a5a00000003, %rdi # imm = 0x5A5A5A5A00000003
               	movabsq	$-0x5a5a5a5a00000002, %rsi # imm = 0xA5A5A5A5FFFFFFFE
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
