
sysv_eightbyte_classes.x64:	file format elf64-x86-64

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

<take_b1>:
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	$0xbb8, %rax            # imm = 0xBB8
               	addq	$0x2, %rax
               	retq

<take_b2>:
               	imulq	$0x64, %rsi, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm0, %rax
               	addq	$0x2, %rax
               	retq

<make_b1>:
               	xorl	%eax, %eax
               	retq

<make_b2>:
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	retq

<take_a1>:
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	retq

<take_a3>:
               	movq	%rdi, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rsi, %rax
               	retq

<take_a5>:
               	subq	$0x18, %rsp
               	movups	%xmm0, (%rsp)
               	movss	(%rsp), %xmm0
               	movss	0xc(%rsp), %xmm2
               	vmulss	<rip>, %xmm2, %xmm2
               	vfmadd132ss	<rip>, %xmm2, %xmm0 # xmm0 = (xmm0 * mem) + xmm2
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	addq	$0x18, %rsp
               	retq

<after_a1>:
               	movq	%rdi, %rax
               	retq

<after_a3>:
               	movq	%rsi, %rax
               	retq

<after_a5>:
               	movaps	%xmm1, %xmm0
               	retq

<ret_a1>:
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$-0x1, %rax
               	movq	%rax, %xmm1
               	retq

<ret_a3>:
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	$-0x1, %rdx
               	retq

<ret_a5>:
               	movabsq	$0x3fc00000, %rax       # imm = 0x3FC00000
               	movq	%rax, %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	movq	$-0x1, %rax
               	movq	%rax, %xmm1
               	retq

<via_a1>:
               	movq	%rdi, %r11
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	movq	$0x2a, %rdi
               	movq	$-0x1, %rsi
               	jmpq	*%r11

<via_a3>:
               	movq	%rdi, %r11
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movq	$0x2a, %rsi
               	movq	$-0x1, %rdx
               	jmpq	*%r11

<via_a5>:
               	movq	%rdi, %r11
               	movabsq	$0x3f800000, %rax       # imm = 0x3F800000
               	movq	%rax, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm1
               	jmpq	*%r11

<main>:
               	subq	$0x38, %rsp
               	leaq	(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movl	$0x2a, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2a, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	movsd	<rip>, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	movq	%rax, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	movups	%xmm0, 0x10(%rsp)
               	leaq	0x10(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x20(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x2c(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x156, %rax            # imm = 0x156
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x156, %rax            # imm = 0x156
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x3, %edi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	callq	<addr>
               	cmpq	$0xbe7, %rax            # imm = 0xBE7
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x38, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	movl	$0x7, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	cmpq	$0x2c3, %rax            # imm = 0x2C3
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x38, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
