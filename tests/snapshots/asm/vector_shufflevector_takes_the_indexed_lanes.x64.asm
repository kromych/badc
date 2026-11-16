
vector_shufflevector_takes_the_indexed_lanes.x64:	file format elf64-x86-64

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

<zip>:
               	vpextrb	$0x0, %xmm0, %eax
               	vpinsrb	$0x0, %eax, %xmm2, %xmm2
               	vpextrb	$0x0, %xmm1, %eax
               	vpinsrb	$0x1, %eax, %xmm2, %xmm2
               	vpextrb	$0x1, %xmm0, %eax
               	vpinsrb	$0x2, %eax, %xmm2, %xmm2
               	vpextrb	$0x1, %xmm1, %eax
               	vpinsrb	$0x3, %eax, %xmm2, %xmm2
               	vpextrb	$0x2, %xmm0, %eax
               	vpinsrb	$0x4, %eax, %xmm2, %xmm2
               	vpextrb	$0x2, %xmm1, %eax
               	vpinsrb	$0x5, %eax, %xmm2, %xmm2
               	vpextrb	$0x3, %xmm0, %eax
               	vpinsrb	$0x6, %eax, %xmm2, %xmm2
               	vpextrb	$0x3, %xmm1, %eax
               	vpinsrb	$0x7, %eax, %xmm2, %xmm2
               	vpextrb	$0x4, %xmm0, %eax
               	vpinsrb	$0x8, %eax, %xmm2, %xmm2
               	vpextrb	$0x4, %xmm1, %eax
               	vpinsrb	$0x9, %eax, %xmm2, %xmm2
               	vpextrb	$0x5, %xmm0, %eax
               	vpinsrb	$0xa, %eax, %xmm2, %xmm2
               	vpextrb	$0x5, %xmm1, %eax
               	vpinsrb	$0xb, %eax, %xmm2, %xmm2
               	vpextrb	$0x6, %xmm0, %eax
               	vpinsrb	$0xc, %eax, %xmm2, %xmm2
               	vpextrb	$0x6, %xmm1, %eax
               	vpinsrb	$0xd, %eax, %xmm2, %xmm2
               	vpextrb	$0x7, %xmm0, %eax
               	movapd	%xmm2, %xmm0
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	vpextrb	$0x7, %xmm1, %eax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	retq

<rev>:
               	vpextrd	$0x3, %xmm0, %eax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x2, %xmm0, %eax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	retq

<cat>:
               	vmovd	%xmm0, %eax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm0, %eax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	vmovd	%xmm1, %eax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm1, %eax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm1, %eax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm1, %eax
               	movapd	%xmm2, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	retq

<lo>:
               	vpextrd	$0x3, %xmm1, %eax
               	vmovd	%eax, %xmm1
               	vmovd	%xmm0, %eax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	retq

<fsh>:
               	vmovd	%xmm1, %eax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x2, %xmm0, %eax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movw	$0x100, -0x60(%rbp)     # imm = 0x100
               	movw	$0x6564, -0x50(%rbp)    # imm = 0x6564
               	movw	$0x302, -0x5e(%rbp)     # imm = 0x302
               	movw	$0x6766, -0x4e(%rbp)    # imm = 0x6766
               	movw	$0x504, -0x5c(%rbp)     # imm = 0x504
               	movw	$0x6968, -0x4c(%rbp)    # imm = 0x6968
               	movw	$0x706, -0x5a(%rbp)     # imm = 0x706
               	movw	$0x6b6a, -0x4a(%rbp)    # imm = 0x6B6A
               	movw	$0x908, -0x58(%rbp)     # imm = 0x908
               	movw	$0x6d6c, -0x48(%rbp)    # imm = 0x6D6C
               	movw	$0xb0a, -0x56(%rbp)     # imm = 0xB0A
               	movw	$0x6f6e, -0x46(%rbp)    # imm = 0x6F6E
               	movw	$0xd0c, -0x54(%rbp)     # imm = 0xD0C
               	movw	$0x7170, -0x44(%rbp)    # imm = 0x7170
               	movw	$0xf0e, -0x52(%rbp)     # imm = 0xF0E
               	movw	$0x7372, -0x42(%rbp)    # imm = 0x7372
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x50(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %eax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x1, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x2, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x3, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x4, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x5, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x6, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x7, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x8, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0x9, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xa, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xb, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xc, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xd, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xe, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrb	$0xf, %xmm0, %ecx
               	leaq	(%rax,%rcx), %rbx
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movapd	%xmm0, %xmm2
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm2, 0x50(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	0x50(%rsp), %xmm2
               	vmovaps	%ymm0, %ymm1
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm2, 0x50(%rsp)
               	vmovups	%ymm1, 0x30(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	movups	0x50(%rsp), %xmm2
               	vmovups	0x30(%rsp), %ymm1
               	imulq	$0x1f, %rbx, %rax
               	vmovd	%xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x1, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x2, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x3, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x1, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x3, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovd	%xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x1, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x2, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrd	$0x3, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	$0x3fc00000, -0x60(%rbp) # imm = 0x3FC00000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x5c(%rbp)
               	movl	$0x40600000, -0x58(%rbp) # imm = 0x40600000
               	movl	$0x40900000, -0x54(%rbp) # imm = 0x40900000
               	leaq	-0x50(%rbp), %r9
               	movss	%xmm0, -0x50(%rbp)
               	movl	$0xc0000000, -0x4c(%rbp) # imm = 0xC0000000
               	movl	$0x0, -0x48(%rbp)
               	movl	$0x41100000, -0x44(%rbp) # imm = 0x41100000
               	leaq	-0x60(%rbp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	vzeroupper
               	callq	<addr>
               	imulq	$0x1f, %rbx, %rax
               	vmovd	%xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0xcd89f746, %eax       # imm = 0xCD89F746
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
