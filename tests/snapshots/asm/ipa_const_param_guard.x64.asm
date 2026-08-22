
ipa_const_param_guard.x64:	file format elf64-x86-64

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

<patch_map>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x0, %rcx
               	movq	0x8(%rax), %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rax), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rax), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x30(%rax), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x38(%rax), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rax), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rax), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rax), %rdx
               	imulq	$0xb, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rax), %rdx
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rax), %rdx
               	imulq	$0xd, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rax), %rdx
               	imulq	$0xe, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rax), %rdx
               	imulq	$0xf, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movq	0x80(%rax), %rdx
               	imulq	$0x11, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x88(%rax), %rdx
               	imulq	$0x12, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x90(%rax), %rdx
               	imulq	$0x13, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x98(%rax), %rdx
               	imulq	$0x14, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xa0(%rax), %rdx
               	imulq	$0x15, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xa8(%rax), %rdx
               	imulq	$0x16, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xb0(%rax), %rdx
               	imulq	$0x17, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xb8(%rax), %rdx
               	imulq	$0x18, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xc0(%rax), %rdx
               	imulq	$0x19, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xc8(%rax), %rdx
               	imulq	$0x1a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xd0(%rax), %rdx
               	imulq	$0x1b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xd8(%rax), %rdx
               	imulq	$0x1c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xe0(%rax), %rdx
               	imulq	$0x1d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xe8(%rax), %rdx
               	imulq	$0x1e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xf0(%rax), %rdx
               	imulq	$0x1f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0xf8(%rax), %rdx
               	shlq	$0x5, %rdx
               	addq	%rdx, %rcx
               	movq	0x100(%rax), %rdx
               	imulq	$0x21, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x108(%rax), %rdx
               	imulq	$0x22, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x110(%rax), %rdx
               	imulq	$0x23, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x118(%rax), %rdx
               	imulq	$0x24, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x120(%rax), %rdx
               	imulq	$0x25, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x128(%rax), %rdx
               	imulq	$0x26, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x130(%rax), %rdx
               	imulq	$0x27, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x138(%rax), %rdx
               	imulq	$0x28, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x140(%rax), %rdx
               	imulq	$0x29, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x148(%rax), %rdx
               	imulq	$0x2a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x150(%rax), %rdx
               	imulq	$0x2b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x158(%rax), %rdx
               	imulq	$0x2c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x160(%rax), %rdx
               	imulq	$0x2d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x168(%rax), %rdx
               	imulq	$0x2e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x170(%rax), %rdx
               	imulq	$0x2f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x178(%rax), %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x180(%rax), %rdx
               	imulq	$0x31, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x188(%rax), %rdx
               	imulq	$0x32, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x190(%rax), %rdx
               	imulq	$0x33, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x198(%rax), %rdx
               	imulq	$0x34, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1a0(%rax), %rdx
               	imulq	$0x35, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1a8(%rax), %rdx
               	imulq	$0x36, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1b0(%rax), %rdx
               	imulq	$0x37, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1b8(%rax), %rdx
               	imulq	$0x38, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1c0(%rax), %rdx
               	imulq	$0x39, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1c8(%rax), %rdx
               	imulq	$0x3a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1d0(%rax), %rdx
               	imulq	$0x3b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1d8(%rax), %rdx
               	imulq	$0x3c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1e0(%rax), %rdx
               	imulq	$0x3d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1e8(%rax), %rdx
               	imulq	$0x3e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1f0(%rax), %rdx
               	imulq	$0x3f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x1f8(%rax), %rdx
               	shlq	$0x6, %rdx
               	addq	%rdx, %rcx
               	movq	0x200(%rax), %rdx
               	imulq	$0x41, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x208(%rax), %rdx
               	imulq	$0x42, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x210(%rax), %rdx
               	imulq	$0x43, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x218(%rax), %rdx
               	imulq	$0x44, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x220(%rax), %rdx
               	imulq	$0x45, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x228(%rax), %rdx
               	imulq	$0x46, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x230(%rax), %rdx
               	imulq	$0x47, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x238(%rax), %rdx
               	imulq	$0x48, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x240(%rax), %rdx
               	imulq	$0x49, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x248(%rax), %rdx
               	imulq	$0x4a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x250(%rax), %rdx
               	imulq	$0x4b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x258(%rax), %rdx
               	imulq	$0x4c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x260(%rax), %rdx
               	imulq	$0x4d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x268(%rax), %rdx
               	imulq	$0x4e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x270(%rax), %rdx
               	imulq	$0x4f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x278(%rax), %rdx
               	imulq	$0x50, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x280(%rax), %rdx
               	imulq	$0x51, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x288(%rax), %rdx
               	imulq	$0x52, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x290(%rax), %rdx
               	imulq	$0x53, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x298(%rax), %rdx
               	imulq	$0x54, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2a0(%rax), %rdx
               	imulq	$0x55, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2a8(%rax), %rdx
               	imulq	$0x56, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2b0(%rax), %rdx
               	imulq	$0x57, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2b8(%rax), %rdx
               	imulq	$0x58, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2c0(%rax), %rdx
               	imulq	$0x59, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2c8(%rax), %rdx
               	imulq	$0x5a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2d0(%rax), %rdx
               	imulq	$0x5b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2d8(%rax), %rdx
               	imulq	$0x5c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2e0(%rax), %rdx
               	imulq	$0x5d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2e8(%rax), %rdx
               	imulq	$0x5e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2f0(%rax), %rdx
               	imulq	$0x5f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x2f8(%rax), %rdx
               	imulq	$0x60, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x300(%rax), %rdx
               	imulq	$0x61, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x308(%rax), %rdx
               	imulq	$0x62, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x310(%rax), %rdx
               	imulq	$0x63, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x318(%rax), %rdx
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x320(%rax), %rdx
               	imulq	$0x65, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x328(%rax), %rdx
               	imulq	$0x66, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x330(%rax), %rdx
               	imulq	$0x67, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x338(%rax), %rdx
               	imulq	$0x68, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x340(%rax), %rdx
               	imulq	$0x69, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x348(%rax), %rdx
               	imulq	$0x6a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x350(%rax), %rdx
               	imulq	$0x6b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x358(%rax), %rdx
               	imulq	$0x6c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x360(%rax), %rdx
               	imulq	$0x6d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x368(%rax), %rdx
               	imulq	$0x6e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x370(%rax), %rdx
               	imulq	$0x6f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x378(%rax), %rdx
               	imulq	$0x70, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x380(%rax), %rdx
               	imulq	$0x71, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x388(%rax), %rdx
               	imulq	$0x72, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x390(%rax), %rdx
               	imulq	$0x73, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x398(%rax), %rdx
               	imulq	$0x74, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3a0(%rax), %rdx
               	imulq	$0x75, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3a8(%rax), %rdx
               	imulq	$0x76, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3b0(%rax), %rdx
               	imulq	$0x77, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3b8(%rax), %rdx
               	imulq	$0x78, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3c0(%rax), %rdx
               	imulq	$0x79, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3c8(%rax), %rdx
               	imulq	$0x7a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3d0(%rax), %rdx
               	imulq	$0x7b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3d8(%rax), %rdx
               	imulq	$0x7c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3e0(%rax), %rdx
               	imulq	$0x7d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3e8(%rax), %rdx
               	imulq	$0x7e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3f0(%rax), %rdx
               	imulq	$0x7f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x3f8(%rax), %rdx
               	shlq	$0x7, %rdx
               	addq	%rdx, %rcx
               	movq	0x400(%rax), %rdx
               	imulq	$0x81, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x408(%rax), %rdx
               	imulq	$0x82, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x410(%rax), %rdx
               	imulq	$0x83, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x418(%rax), %rdx
               	imulq	$0x84, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x420(%rax), %rdx
               	imulq	$0x85, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x428(%rax), %rdx
               	imulq	$0x86, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x430(%rax), %rdx
               	imulq	$0x87, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x438(%rax), %rdx
               	imulq	$0x88, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x440(%rax), %rdx
               	imulq	$0x89, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x448(%rax), %rdx
               	imulq	$0x8a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x450(%rax), %rdx
               	imulq	$0x8b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x458(%rax), %rdx
               	imulq	$0x8c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x460(%rax), %rdx
               	imulq	$0x8d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x468(%rax), %rdx
               	imulq	$0x8e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x470(%rax), %rdx
               	imulq	$0x8f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x478(%rax), %rdx
               	imulq	$0x90, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x480(%rax), %rdx
               	imulq	$0x91, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x488(%rax), %rdx
               	imulq	$0x92, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x490(%rax), %rdx
               	imulq	$0x93, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x498(%rax), %rdx
               	imulq	$0x94, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4a0(%rax), %rdx
               	imulq	$0x95, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4a8(%rax), %rdx
               	imulq	$0x96, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4b0(%rax), %rdx
               	imulq	$0x97, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4b8(%rax), %rdx
               	imulq	$0x98, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4c0(%rax), %rdx
               	imulq	$0x99, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4c8(%rax), %rdx
               	imulq	$0x9a, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4d0(%rax), %rdx
               	imulq	$0x9b, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4d8(%rax), %rdx
               	imulq	$0x9c, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4e0(%rax), %rdx
               	imulq	$0x9d, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4e8(%rax), %rdx
               	imulq	$0x9e, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4f0(%rax), %rdx
               	imulq	$0x9f, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x4f8(%rax), %rdx
               	imulq	$0xa0, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x500(%rax), %rdx
               	imulq	$0xa1, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x508(%rax), %rdx
               	imulq	$0xa2, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x510(%rax), %rdx
               	imulq	$0xa3, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x518(%rax), %rdx
               	imulq	$0xa4, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x520(%rax), %rdx
               	imulq	$0xa5, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x528(%rax), %rdx
               	imulq	$0xa6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x530(%rax), %rdx
               	imulq	$0xa7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x538(%rax), %rdx
               	imulq	$0xa8, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x540(%rax), %rdx
               	imulq	$0xa9, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x548(%rax), %rdx
               	imulq	$0xaa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x550(%rax), %rdx
               	imulq	$0xab, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x558(%rax), %rdx
               	imulq	$0xac, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x560(%rax), %rdx
               	imulq	$0xad, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x568(%rax), %rdx
               	imulq	$0xae, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x570(%rax), %rdx
               	imulq	$0xaf, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x578(%rax), %rdx
               	imulq	$0xb0, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x580(%rax), %rdx
               	imulq	$0xb1, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x588(%rax), %rdx
               	imulq	$0xb2, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x590(%rax), %rdx
               	imulq	$0xb3, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x598(%rax), %rax
               	imulq	$0xb4, %rax, %rax
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	addq	$0x3, %rax
               	retq

<map_a>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %esi
               	popq	%rbp
               	jmp	<addr>

<map_b>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %esi
               	popq	%rbp
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, (%rsi,%rdx,8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0xb4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rdx
               	movq	(%rsi,%rdx,8), %rdi
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0xb4, %eax
               	jl	<addr>
               	leaq	0xa(%rcx), %rbx
               	movl	$0x7, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
